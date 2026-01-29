//
//  APIConstants.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import Foundation

/// Centralized API configuration
enum APIConstants {

    /// Base URL for GitHub APIs
    static let baseURL = "https://api.github.com"

    /// Endpoints
    enum Endpoint {
        static let squareRepositories = "/orgs/square/repos"
    }
}
