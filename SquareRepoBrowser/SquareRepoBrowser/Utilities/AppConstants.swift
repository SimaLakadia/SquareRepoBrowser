//
//  AppConstants.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import Foundation

/// Centralized app-wide constants and user-facing messages
enum AppConstants {

    enum Messages {
        static let noRepositoriesFound = "No repositories found."
        static let noInternetConnection = "No internet connection. Please check your network."
        static let unauthorizedRequest = "Unauthorized request."
        static let dataNotFound = "Data not found."
        static let serverError = "Server error. Please try again later."
        static let failedToLoadRepositories = "Failed to load repositories. Please try again."
        static let successStateReturned = "Success state returned"
    }

    enum Errors {
        static let invalidAPIURL = "Invalid API URL"
        static let genericError = "Something went wrong"
        static let failureStateReturned = "Failure state returned"
    }

    enum Network {
        static let contentTypeJSON = "application/json"
    }

    enum Reachability {
        static let monitorQueueLabel = "ReachabilityMonitor"
    }
}
