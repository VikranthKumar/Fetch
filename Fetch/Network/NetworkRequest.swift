//
//  NetworkRequest.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import Foundation

enum NetworkRequest {
    case mealsList
    case mealDetails(mealId: String)
}

extension NetworkRequest {
    var baseUrl: String {
        NetworkEnvironment.active.baseUrl
    }
    
    var path: String {
        switch self {
            case .mealsList:
                return "filter.php?c=Dessert"
            case let .mealDetails(mealId):
                return "lookup.php?i=\(mealId)"
        }
    }
    
    var url: URL {
        baseUrl.appending(path).url!
    }
    
    func buildURLRequest() -> URLRequest {
        URLRequest(url: url)
    }
}

