//
//  DataResponsePublisher+.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 24/03/2024.
//

/**
import Alamofire
import Combine
import Foundation

extension DataResponsePublisher {
    func handleResponse<T: Decodable>() -> AnyPublisher<T, NetworkError> {
        tryMap {
            guard let data = $0.data else {
                throw NetworkError(.invalidResponse)
            }
            
            NetworkLogger.httpResponseLogger(data, $0.response!)

            return try JSONDecoder().decode(T.self, from: data)
        }
        .mapError { NetworkError(.networkError($0)) }
        .eraseToAnyPublisher()
    }
    
    func handleResponseData() -> AnyPublisher<Data, NetworkError> {
        tryMap {
            guard let data = $0.data else {
                throw NetworkError(.invalidResponse)
            }
            
            NetworkLogger.httpResponseLogger(data, $0.response!)
            
            return data
        }
        .mapError { NetworkError(.networkError($0)) }
        .eraseToAnyPublisher()
    }
}
**/
