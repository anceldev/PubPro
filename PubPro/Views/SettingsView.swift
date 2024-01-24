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
//    @Binding var userViewModel: UserViewModel
    @State var newName: String = ""
    @State private var confirmChanges = false
    
    @State private var image = UIImage()
    @State private var showImagePicker = false
    @State private var showCameraPicker = false
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    TitleView(title: "Settings", hasTable: false)
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
                VStack {
                    Text("Update your username:")
                    TextField("Username", text: $newName, prompt: Text("New username"))
                        .ownTfStyle()
                }
                .padding(15)
                Button("Update changes", action: updateProfileData)
                    .buttonStyle(.borderedProminent)
                    .confirmationDialog("Change profile", isPresented: $confirmChanges, actions: {
                        Button("Ok") {
                            print("Ok to confirmation dialog")
                            confirmChanges = false
                            newName = ""
                        }
                    }, message: {
                        Text("Your name has been updated")
                    })
                Spacer()
                Button("SignOut", action: signOutAccount)
                    .foregroundStyle(.red.opacity(0.7))
                Spacer()
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
//        if let userID = userViewModel.user.id {
//            StorageManager.downloadAvatar(uidUser: userID) { image in
//                if let uiImage = image {
//                    self.image = uiImage
//                } else {
//                    print("Cant use image")
//                }
//            }
//        }
    }
    private func updateProfileData() {
//        let nameRequest = authViewModel.userProfileChangeRequest(username: newName)
//        let photoRequest = userViewModel.requestAvatarChange(uiImage: image)
//        
//        if !nameRequest && !photoRequest {
//            print("No changes")
//        }
//        else {
//            self.confirmChanges = true
//            if nameRequest {
//                userViewModel.user.name = newName // Update name locally for this sesion
//                print("Name updated")
//            }
//            if photoRequest {
//                print("Photo updated")
//            }
//        }
    }
}

#Preview {
//    @State var userViewModel = UserViewModel()
//    return SettingsView(userViewModel: $userViewModel)
//        .environmentObject(AuthenticationViewModel())
    
    SettingsView()
}
