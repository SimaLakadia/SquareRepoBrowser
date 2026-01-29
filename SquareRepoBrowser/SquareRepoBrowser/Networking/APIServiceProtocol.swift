//
//  APIServiceProtocol.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import Foundation

/// Protocol to allow injecting/mock API service implementations in tests
protocol APIServiceProtocol {
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        body: Data?,
        completion: @escaping (Result<T, APIError>) -> Void
    )
}
