//
//  EmptyDataView.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import SwiftUI

struct EmptyDataView: View {
    
    enum ViewType {
        case mealsList
        
        var image: String {
            switch self {
                case .mealsList:
                    return .noMealsFoundImage
            }
        }
        
        var message: String {
            switch self {
                case .mealsList:
                    return .noMealsFoundMessage
            }
        }
    }
    
    let type: ViewType
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: type.image)
                .font(.image)
            Text(type.message)
                .font(.small)
            Spacer()
        }
        .background(ignoresSafeAreaEdges: .all)
        .edgesIgnoringSafeArea(.all)
        .fullFrame()
    }
    
}
