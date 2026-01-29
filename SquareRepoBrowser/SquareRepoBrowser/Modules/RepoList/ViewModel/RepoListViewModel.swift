//
//  RepoListViewModel.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import Foundation

/// ViewModel responsible for fetching Square GitHub repositories
/// and exposing UI-ready state to the ViewController.
final class RepoListViewModel {

    // MARK: - State

    /// Represents UI state changes for the repository list screen
    enum State {
        case loading
        case success([Repository])
        case failure(String)
    }

    // MARK: - Properties

    /// API service dependency (injectable for testing)
    private let apiService: APIServiceProtocol

    /// State change observer used by the ViewController
    var onStateChange: ((State) -> Void)?

    // MARK: - Initializer

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }

    // MARK: - Public Methods

    /// Fetches repositories for the Square organization
    func fetchRepositories() {

        // Always show loading immediately
        onStateChange?(.loading)

        guard let url = URL(
            string: APIConstants.baseURL + APIConstants.Endpoint.squareRepositories
        ) else {
            onStateChange?(.failure(AppConstants.Errors.invalidAPIURL))
            return
        }

        apiService.request(
            url: url,
            method: .get,
            body: nil
        ) { [weak self] (result: Result<[Repository], APIError>) in

            DispatchQueue.main.async {
                switch result {

                case .success(let repositories):
                    self?.onStateChange?(.success(repositories))

                case .failure(let error):
                    self?.onStateChange?(
                        .failure(self?.errorMessage(from: error)
                                 ?? AppConstants.Errors.genericError)
                    )
                }
            }
        }
    }

}

// MARK: - Error Handling
extension RepoListViewModel {

    /// Maps APIError to user-friendly error messages
    func errorMessage(from error: APIError) -> String {
        switch error {
        case .noInternet:
            return AppConstants.Messages.noInternetConnection
        case .unauthorized:
            return AppConstants.Messages.unauthorizedRequest
        case .notFound:
            return AppConstants.Messages.dataNotFound
        case .serverError:
            return AppConstants.Messages.serverError
        default:
            return AppConstants.Messages.failedToLoadRepositories
        }
    }
}
