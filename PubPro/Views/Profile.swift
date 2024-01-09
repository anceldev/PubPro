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
    
    var user: User
    @State var myQR: Image?
    
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "Profile")
            }
            .padding(33)
            VStack{
                Text("Welcome")
                    .font(.custom("RobotoCondensed-Regular", size: 32))
                Text(user.name.isEmpty ? user.email : user.name)
                    .font(.custom("RobotoCondensed-Black", size: 32))
                Text("You have")
                    .font(.custom("RobotoCondensed-Medium", size: 18))
                    .foregroundStyle(.beerOrange)
                Text("\(user.points)")
                    .foregroundStyle(.ppDark)
                    .font(.custom("RobotoCondensed-Black", size: 70))
                Text("Points")
                    .foregroundStyle(.beerYellow)
                    .font(.custom("RobotoCondensed-Bold", size: 24))
            }
            VStack{
                if let profileQR = myQR {
                    profileQR
                        .resizable()
                        .frame(width: 350, height: 350)
                }
//                if myQR != nil {
//                    let personalQR = myQR!
//                    personalQR
//                        .resizable()
//                        .frame(width: 300, height: 300)
//                }
                
            }
            .padding(30)
            Spacer()
            Spacer()

        }
        .padding(.top, 33)
        .background(.ppDarkWhite)
        .onAppear(perform: {
            generateQRCode()
        })
    }
    func signOutAccout() {
        authViewModel.signOut()
    }
    func generateQRCode() {
        guard let uiImageQR = try? QRCode(string: user.id ?? "No image", size: CGSize(width: 400, height: 400))?.image() else {
            fatalError("Can't generate QR code")
        }
        self.myQR = Image(uiImage: uiImageQR)
        print(user.id)
    }
}

#Preview {
    Profile(user: User.empty)
        .environmentObject(AuthenticationViewModel())
}
