//
//  View+Custom.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import SwiftUI

struct FirstAppearAction: ViewModifier {
    
    @State var shouldTriggerAction: Bool = true
    
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if self.shouldTriggerAction {
                    self.shouldTriggerAction = false
                    self.action?()
                }
            }
    }
    
}
