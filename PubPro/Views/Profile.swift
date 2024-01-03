//
//  Profile.swift
//  PubPro
//
//  Created by Ancel Dev account on 18/12/23.
//

import SwiftUI
import SwiftData
import QRCode

struct Profile: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @State var user: User
    @State var myQR: Image?
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            VStack{
                Text("¡Welcome!")
                Text(user.name)
                Text("You have \(user.points) points")
                Text("Your role is: \(user.role.rawValue)")
                
//                if let personalQR = myQR {
//                    personalQR
//                        .resizable()
//                        .frame(width: 350, height: 350)
//                }
//                
//                if myQR != nil {
//                    let personalQR = myQR!
//                    personalQR
//                        .resizable()
//                        .frame(width: 300, height: 300)
//                }
                
            }
            Spacer()
            Spacer()
            Button("SignOut", action: signOutAccout)
                .foregroundStyle(.red.opacity(0.7))
            Spacer()
        }
        .onAppear(perform: {
            generateQRCode()
        })
    }
    func signOutAccout() {
        authViewModel.signOut()
    }
    func generateQRCode() {
//        guard let imageQR = try? QRCode(string: authViewModel.user!.providerID, size: CGSize(width: 400, height: 400))?.image() else {
//            fatalError("Can't generate QR code")
//        }
//        self.myQR = Image(uiImage: imageQR)
    }
}

#Preview {
    Profile(user: User.empty)
        .environmentObject(AuthenticationViewModel())
}
