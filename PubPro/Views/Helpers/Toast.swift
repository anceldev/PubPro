//
//  ToastView.swift
//  PubPro
//
//  Created by Ancel Dev account on 17/1/24.
//

import SwiftUI


struct ToastDataModel {
    var title: String
    var image: String
}

struct Toast: View {
    let dataModel: ToastDataModel
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: dataModel.image)
                Text(dataModel.title)
            }
            .font(.headline)
            .foregroundStyle(.primary)
            .padding([.top, .bottom], 20)
            .padding([.leading, .trailing], 40)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(Capsule())
        }
        .frame(width: UIScreen.main.bounds.width / 1.25)
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.show = false
                }
            }
        }
    }
}
struct ToastModifier: ViewModifier {
    @Binding var show: Bool
    let toastView: Toast
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                toastView
            }
        }
    }
}

extension View {
    func toast(toastView: Toast, show: Binding<Bool>) -> some View {
        self.modifier(ToastModifier(show: show, toastView: toastView))
    }
}
