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

struct FontRobotoRegular: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("RobotoCondensed-Regular", size: size))
    }
}
struct FontRobotoBold: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("RobotoCondensed-Bold", size: size))
    }
}
struct FontRobotoMedium: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("RobotoCondensed-Medium", size: size))
    }
}
struct FontRobotoBlack: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("RobotoCondensed-Black", size: size))
    }
}
struct FontRobotoLight: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(Font.custom("RobotoCondensed-Light", size: size))
    }
}

struct TabViewsModifier: ViewModifier {
    let title: String
    let sysImage: String
    func body(content: Content) -> some View {
        content
            .tabItem { Label(title, systemImage: sysImage) }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.ppDark, for: .tabBar)
    }
}

extension View {
    func ownButtonStyle() -> some View {
        modifier(ButtonModifier())
    }
    func ownTfStyle() -> some View {
        modifier(TextFieldModifier())
    }
    /// Custom font modifers
    func robotoBlack(_ size: CGFloat) -> some View {
        modifier(FontRobotoBlack(size: size))
    }
    func robotoBold(_ size: CGFloat) -> some View {
        modifier(FontRobotoBold(size: size))
    }
    func robotoMedium(_ size: CGFloat) -> some View {
        modifier(FontRobotoMedium(size: size))
    }
    func robotoRegular(_ size: CGFloat) -> some View {
        modifier(FontRobotoRegular(size: size))
    }
    func robotoLight(_ size: CGFloat) -> some View {
        modifier(FontRobotoLight(size: size))
    }
    func mainTabView(_ title: String, systemImage: String) -> some View {
        modifier(TabViewsModifier(title: title, sysImage: systemImage))
    }
}
