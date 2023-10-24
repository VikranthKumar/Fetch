//
//  LoaderView.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import SwiftUI

struct LoaderView: View {
    
    let didFail: Binding<Bool>
    let action: (() -> Void)
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            if didFail.wrappedValue {
                Image(systemName: .errorImage)
                    .font(.image)
                    .foregroundColor(.red)
                Text(String.networkError)
                    .font(.small)
                    .multilineTextAlignment(.center)
                Button(action: {
                    action()
                }) {
                    Text(String.refresh)
                        .font(.extraSmall)
                        .foregroundColor(.white)
                        .padding(12)
                        .padding(.horizontal, 12)
                        .background(.black)
                        .cornerRadius(8)
                }
                .plainButton()
            } else {
                ProgressView()
                    .controlSize(.large)
                Text(String.loading)
                    .font(.small)
            }
            Spacer()
        }
        .background(ignoresSafeAreaEdges: .all)
        .edgesIgnoringSafeArea(.all)
        .fullFrame()
    }
        
}
