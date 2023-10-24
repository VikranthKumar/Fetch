//
//  NetworkResponse.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import Foundation

enum NetworkError: Error {
    case server
    case unknown
    case decodingError
}

enum NetworkResponse {
    case some(origin: NetworkRequest, output: (data: Data, response: URLResponse))
    case error(Error)
    
    case mealsList(Meals)
    case mealDetails(Meals)
}

extension NetworkResponse {
    var isError: Bool {
        switch self {
            case .error:
                return true
            default:
                return false
        }
    }
}

extension NetworkResponse {
    func unwrap<T: Decodable>(_: (T) -> NetworkResponse) throws -> T {
        let decoder = JSONDecoder()
        guard case let .some(_, output) = self else {
            if case let .error(error) = self {
                throw error
            } else {
                throw NetworkError.unknown
            }
        }
        do {
            return try decoder.decode(T.self, from: output.data)
        } catch(let error) {
            print(error)
            throw NetworkError.decodingError
        }
    }
}
