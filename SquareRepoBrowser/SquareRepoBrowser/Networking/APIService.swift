//  APIService.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import Foundation

/// Handles all API requests in a centralized way
final class APIService : APIServiceProtocol {

    // MARK: - Singleton
    static let shared = APIService()
    private init() {}

    // MARK: - Public Request Method

    /// Performs a network request and decodes the response
    /// - Parameters:
    ///   - url: API endpoint
    ///   - method: HTTP method (GET / POST)
    ///   - body: Optional request body
    ///   - completion: Result with decoded response or APIError
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod = .get,
        body: Data? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {

        // Check internet availability
        Reachability.shared.checkConnection { isConnected in
            guard isConnected else {
                completion(.failure(.noInternet))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.setValue(AppConstants.Network.contentTypeJSON, forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, response, error in
                
                // Handle request-level error
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                
                // Validate HTTP response
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                switch httpResponse.statusCode {
                    
                case 200...299:
                    guard let data = data else {
                        completion(.failure(.emptyData))
                        return
                    }
                    
                    do {
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                    
                case 401:
                    completion(.failure(.unauthorized))
                    
                case 404:
                    completion(.failure(.notFound))
                    
                case 500...599:
                    completion(.failure(.serverError))
                    
                default:
                    completion(.failure(.unknownStatusCode(httpResponse.statusCode)))
                }
                
            }.resume()
        }
    }
}
