@testable import SquareRepoBrowser
import Foundation

final class MockAPIService: APIServiceProtocol {

    enum ResultType {
        case success(Decodable)
        case failure(APIError)
    }

    var resultType: ResultType?

    func request<T>(
        url: URL,
        method: HTTPMethod,
        body: Data?,
        completion: @escaping (Result<T, APIError>) -> Void
    ) where T : Decodable {

        switch resultType {

        case .success(let value):
            completion(.success(value as! T))

        case .failure(let error):
            completion(.failure(error))

        case .none:
            break
        }
    }
}
