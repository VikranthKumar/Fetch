//
//  Optional++.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/24/23.
//

import Foundation

extension Optional where Wrapped == String {
    var unWrapped: String {
        self ?? .empty
    }
}
