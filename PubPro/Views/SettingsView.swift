//
//  SettingsView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import PhotosUI
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Binding var userViewModel: UserViewModel
    @State var userName: String = ""
    @State private var confirmChanges = false
    
    @State private var image = UIImage()
    @State private var showImagePicker = false
    @State private var showCameraPicker = false
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    TitleView(title: "Settings")
                }
                .padding(33)
                VStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                    HStack {
                        Button("Chose avatar") {
                            showImagePicker.toggle()
                            showCameraPicker = false
                        }
                        Button("Take a photo") {
                            showImagePicker = false
                            showCameraPicker.toggle()
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal, 15)
                Spacer()
                Text("Update your profile data:")
                TextField("Username", text: $userName)
                Button("Update", action: updateProfileData)
                    .buttonStyle(.borderedProminent)
                    .confirmationDialog("Change profile", isPresented: $confirmChanges, actions: {
                        Button("Ok") {
                            print("Ok to confirmation dialog")
                            confirmChanges = false
                            userName = ""
                        }
                    }, message: {
                        Text("Your name has been updated")
                    })
                Spacer()
                Button("SignOut", action: signOutAccount)
                    .foregroundStyle(.red.opacity(0.7))
            }
        }
        .onAppear(perform: getAvatarImage)
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        })
        .sheet(isPresented: $showCameraPicker, content: {
            ImagePicker(sourceType: .camera, selectedImage: self.$image)
        })
        .background(.ppDarkWhite)
    }
    private func signOutAccount() {
        authViewModel.signOut()
    }
    private func getAvatarImage() {
        StorageManager.downloadAvatar(uidUser: userViewModel.user.id!) { image in
            if let uiImage = image {
                self.image = uiImage
            } else {
                print("Cant use image")
            }
        }
    }
    private func updateProfileData() {
        let nameRequest = authViewModel.userProfileChangeRequest(username: userName)
        let photoRequest = userViewModel.requestAvatarChange(uiImage: image)
        
        if nameRequest && photoRequest {
            self.confirmChanges = true
            userViewModel.user.name = userName // Update name locally for this sesion
        }
    }
}

#Preview {
    @State var userViewModel = UserViewModel()
    return SettingsView(userViewModel: $userViewModel)
        .environmentObject(AuthenticationViewModel())
}
