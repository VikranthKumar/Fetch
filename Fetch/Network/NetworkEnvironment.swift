//
//  NetworkEnvironment.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/21/23.
//

import Foundation

enum NetworkEnvironment {
    case production
}

extension NetworkEnvironment {
    static var active: Self {
        .production
    }
}

extension NetworkEnvironment {
    var baseUrl: String {
        "https://themealdb.com/api/json/v1/1/"
    }
}
