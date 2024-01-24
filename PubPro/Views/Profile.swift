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
//    @Environment(UserViewModel.self) var userViewModel
//    @State var myQR: Image?
    
    var body: some View {
        VStack {
//            VStack {
//                TitleView(title: "Profile", hasTable: false)
//            }
//            .padding(33)
//            VStack{
//                Text("Welcome")
//                    .font(.custom("RobotoCondensed-Regular", size: 32))
//                Text(userViewModel.user.name.isEmpty ? userViewModel.user.email : userViewModel.user.name)
//                    .font(.custom("RobotoCondensed-Black", size: 32))
//                Text("You have")
//                    .font(.custom("RobotoCondensed-Medium", size: 18))
//                    .foregroundStyle(.beerOrange)
//                Text("\(userViewModel.user.points)")
//                    .foregroundStyle(.ppDark)
//                    .font(.custom("RobotoCondensed-Black", size: 70))
//                Text("Points")
//                    .foregroundStyle(.beerYellow)
//                    .font(.custom("RobotoCondensed-Bold", size: 24))
//            }
//            VStack{
//                if let profileQR = myQR {
//                    profileQR
//                        .resizable()
//                        .frame(width: 350, height: 350)
//                }
//            }
//            Spacer()
        }
        .background(.ppDarkWhite)
//        .onAppear {
//            userViewModel.suscribe()
//            generateQRCode()
//        }
    }
    func signOutAccout() {
        authViewModel.signOut()
    }
//    func generateQRCode() {
//        guard let uiImageQR = try? QRCode(string: userViewModel.user.email, size: CGSize(width: 400, height: 400))?.image() else {
//            fatalError("Can't generate QR code")
//        }
//        self.myQR = Image(uiImage: uiImageQR)
//    }
}

#Preview {
    Profile()
        .environmentObject(AuthenticationViewModel())
//        .environment(UserViewModel())
}
