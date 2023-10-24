//
//  RemoteImage.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/23/23.
//

import SwiftUI

struct RemoteImage: View {
    
    let url: String
    
    var body: some View {
        AsyncImage(
            url: url.url,
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                        .controlSize(.mini)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: .errorImage)
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
            }
        }
    }
    
}
