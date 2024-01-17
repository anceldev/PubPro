//
//  Modifiers.swift
//  PubPro
//
//  Created by Ancel Dev account on 11/1/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            
            .tint(.white)
            .buttonStyle(.borderedProminent)
            
    }
}
struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(15)
            .background(.ppDarkWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func ownButtonStyle() -> some View {
        modifier(ButtonModifier())
    }
    
    func ownTfStyle() -> some View {
        modifier(TextFieldModifier())
    }
}
