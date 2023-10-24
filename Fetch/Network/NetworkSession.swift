//
//  NetworkSession.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import Foundation
import Combine

class NetworkSession: NSObject {
    
    static let shared = NetworkSession()
    
    let urlSession = URLSession(configuration: .default)
    
    func task(with request: NetworkRequest) -> AnyPublisher<NetworkResponse, Never> {
        urlSession
            .dataTaskPublisher(for: request.buildURLRequest())
            .tryMap { .some(origin: request, output: $0) }
            .catch { Just(.error($0)) }
            .eraseToAnyPublisher()
    }
    
}
