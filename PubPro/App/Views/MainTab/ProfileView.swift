//
//  ProfileView.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(PubProViewModel.self) private var viewModel
    @Environment(NavigationState.self) private var navState
    var body: some View {
        VStack {
            Text("Profile View")
            Button("Logout") {
                viewModel.logout()
                navState.routes = [.signIn]
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProfileView()
        .environment(PubProViewModel())
        .environment(NavigationState())
}
