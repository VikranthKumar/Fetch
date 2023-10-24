//
//  View++.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import SwiftUI

extension View {
    func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(FirstAppearAction(action: action))
    }
}

extension View {
    func fullWidth(alignment: Alignment = .center) -> some View {
        frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
    }
    
    func fullHeight(alignment: Alignment = .center) -> some View {
        frame(minHeight: 0, maxHeight: .infinity, alignment: alignment)
    }
    
    func fullFrame() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    func plainButton() -> some View {
        buttonStyle(PlainButtonStyle())
    }
    
    func primaryButton() -> some View {
        self
            .font(.extraSmall)
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .fullWidth()
            .background(.black)
            .cornerRadius(8)
            .buttonStyle(PlainButtonStyle())
    }
}
