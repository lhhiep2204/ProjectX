//
//  BaseService.swift
//  Networking
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Alamofire
import Combine

/// A protocol defining the base structure for network service interactions.
public protocol IBaseService {
    /// Makes a generic network request and returns a Combine publisher for the specified response type.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher for the decoded response or a network error.
    func makeRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError>

    /// Makes a generic upload network request and returns a Combine publisher for the specified response type.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher for the decoded response or a network error.
    func makeUploadRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError>
}

public class BaseService: IBaseService {
    public static let shared = BaseService()
    private var cancellables = Set<AnyCancellable>()

    private init() {}

    private let session: Session = {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 60

        return Session(configuration: config)
    }()
}

public extension BaseService {
    func makeRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError> {
        guard let request = request as? BaseAPIRequest else {
            return Fail(error: .init(.invalidUrl)).eraseToAnyPublisher()
        }

        guard let url = URL(string: request.baseURL + request.endpoint) else {
            return Fail(error: .init(.invalidPayload)).eraseToAnyPublisher()
        }

        return session.request(url,
                               method: getHTTPMethod(from: request.method),
                               parameters: request.parameters,
                               encoding: getParamEncoding(from: request.method),
                               headers: getHTTPHeaders(form: request.headers),
                               interceptor: self)
        .validate()
        .publishData()
        .handleResponse()
    }

    func makeUploadRequest<T: Decodable>(request: BaseRequest) -> AnyPublisher<T, NetworkError> {
        guard let request = request as? BaseUploadRequest else {
            return Fail(error: .init(.invalidUrl)).eraseToAnyPublisher()
        }

        guard let url = URL(string: request.baseURL + request.endpoint) else {
            return Fail(error: .init(.invalidPayload)).eraseToAnyPublisher()
        }

        guard let multipartFormData = getMultipartFormData(from: request.fileInfo) else {
            return Fail(error: .init(.invalidPayload)).eraseToAnyPublisher()
        }

        return session.upload(multipartFormData: multipartFormData,
                              to: url,
                              method: getHTTPMethod(from: request.method),
                              headers: getHTTPHeaders(form: request.headers),
                              interceptor: self)
        .validate()
        .publishData()
        .handleResponse()
    }
}

extension BaseService: RequestInterceptor {
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest

        let token = "[ACCESS_TOKEN]"
        let accessToken = "Bearer \(token)"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")

        NetworkLogger.httpRequestLogger(request)

        completion(.success(request))
    }

    public func retry(_ request: Request,
                      for session: Session,
                      dueTo error: Error,
                      completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }

        guard request.retryCount < 3 else {
            completion(.doNotRetry)
            return
        }

        print("Retry \(request.retryCount) time(s) with statusCode: \(statusCode)")

        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        case 401:
            makeRequest(request: RefreshTokenRequest())
                .sink { result in
                    if case .failure(let error) = result {
                        print("Refresh token error: \(error.localizedDescription)")
                        completion(.doNotRetry)
                    }
                } receiveValue: { (value: String) in
                    completion(.retry)
                }
                .store(in: &cancellables)
        default:
            completion(.doNotRetry)
        }
    }
}

extension BaseService {
    private func getHTTPMethod(from method: RequestMethod) -> HTTPMethod {
        switch method {
        case .get: .get
        case .post: .post
        case .put: .put
        case .patch: .patch
        case .delete: .delete
        }
    }

    private func getParamEncoding(from method: RequestMethod) -> ParameterEncoding {
        switch method {
        case .get, .delete: URLEncoding.default
        case .post, .put, .patch: JSONEncoding.default
        }
    }

    private func getHTTPHeaders(form header: [String: String]?) -> HTTPHeaders? {
        guard let header else { return nil }

        return .init(header)
    }

    private func getMultipartFormData(from fileInfo: FileInfo) -> ((MultipartFormData) -> Void)? {
        guard let filePath = fileInfo.filePath.data(using: .utf8) else { return nil }

        return { multipartFormData in
            multipartFormData.append(filePath,
                                     withName: "[KEY_NAME]")
            multipartFormData.append(fileInfo.file,
                                     withName: "[FILE]",
                                     fileName: fileInfo.fileName,
                                     mimeType: fileInfo.mimeType)
        }
    }
}

extension DataResponsePublisher {
    func handleResponse<T: Decodable>() -> AnyPublisher<T, NetworkError> {
        self.tryMap { response -> T in
            guard let data = response.data else {
                throw NetworkError(.invalidResponse)
            }

            NetworkLogger.httpResponseLogger(data, response.response)

            return try JSONDecoder().decode(T.self, from: data)
        }
        .mapError { error in
            NetworkError(.networkError(error))
        }
        .eraseToAnyPublisher()
    }
}
