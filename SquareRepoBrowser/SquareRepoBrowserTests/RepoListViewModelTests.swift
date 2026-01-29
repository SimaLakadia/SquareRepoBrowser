//
//  RepoListViewModelTests.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

@testable import SquareRepoBrowser
import XCTest

final class RepoListViewModelTests: XCTestCase {

    private var viewModel: RepoListViewModel!
    private var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = RepoListViewModel(apiService: mockAPIService)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    // MARK: - Success Case

    func testFetchRepositories_Success() {
        // Given
        let repo = Repository.mock()

        mockAPIService.resultType = .success([repo])

        let expectation = XCTestExpectation(description: AppConstants.Messages.successStateReturned)

        viewModel.onStateChange = { state in
            if case .success(let repos) = state {
                XCTAssertEqual(repos.count, 1)
                XCTAssertEqual(repos.first?.name, "square-test")
                expectation.fulfill()
            }
        }

        // When
        viewModel.fetchRepositories()

        // Then
        wait(for: [expectation], timeout: 1.0)
    }


    // MARK: - Failure Case

    func testFetchRepositories_NoInternetFailure() {
        // Given
        mockAPIService.resultType = .failure(.noInternet)

        let expectation = XCTestExpectation(description: AppConstants.Errors.failureStateReturned)

        viewModel.onStateChange = { state in
            if case .failure(let message) = state {
                XCTAssertEqual(
                    message,
                    AppConstants.Messages.noInternetConnection
                )
                expectation.fulfill()
            }
        }

        // When
        viewModel.fetchRepositories()

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
