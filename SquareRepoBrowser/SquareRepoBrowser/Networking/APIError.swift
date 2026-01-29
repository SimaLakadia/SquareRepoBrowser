//
//  APIError.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

enum APIError: Error {
    case noInternet
    case invalidResponse
    case emptyData
    case decodingFailed
    case unauthorized
    case notFound
    case serverError
    case unknownStatusCode(Int)
    case requestFailed(Error)
}
