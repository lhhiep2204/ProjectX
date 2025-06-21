//
//  DSAsyncImage.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 9/6/24.
//

import SwiftUI

struct CacheAsyncImage<Content: View>: View {
    private let url: URL
    private let content: (AsyncImagePhase) -> Content

    init(url: URL, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }

    var body: some View {
        if let cachedImage = ImageCache.shared[url] {
            content(.success(cachedImage))
        } else {
            AsyncImage(url: url) { cacheAndRender(phase: $0) }
        }
    }

    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache.shared[url] = image
        }
        return content(phase)
    }
}

fileprivate class ImageCache {
    static let shared = ImageCache()
    private var cache: [URL: Image] = [:]

    private init() {}

    subscript(url: URL) -> Image? {
        get { cache[url] }
        set { cache[url] = newValue }
    }
}
