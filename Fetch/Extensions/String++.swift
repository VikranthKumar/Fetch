//
//  String++.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/21/23.
//

import Foundation

extension String {
    var url: URL? {
        URL(string: self)
    }
    
    var empty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: String.space, with: String.empty).isEmpty
    }
}

extension String: Identifiable {
    public var id: Int {
        hash
    }
}
