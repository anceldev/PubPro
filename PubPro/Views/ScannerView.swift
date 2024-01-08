//
//  ScannerView.swift
//  PubPro
//
//  Created by Ancel Dev account on 19/12/23.
//

import CodeScanner
import SwiftUI

struct ScannerView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State var isPresentingScanner = false
    @State var scannedCode: String = ""
    
    var drinks: [Drink] = [
        Drink(name: "Cóctel", descriptionItem: "Description of cóctel", value: 50),
        Drink(name: "Cachimba", descriptionItem: "Description of cachimba", value: 100),
        Drink(name: "Combinado", descriptionItem: "Description of combinado", value: 70)
    ]
    
    @State private var buttonsBar: ButtonsBar = .none
    
    enum ButtonsBar {
        case drinks
        case rewards
        case none
    }
    
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    scannedCode = code.string
                    isPresentingScanner = false
                }
            })
    }
    
    var body: some View {
        VStack {
            VStack {
                TitleView(title: "Scanner")
            }
            .padding(33)
            
            VStack {
                Spacer()
                if scannedCode.isEmpty {
                    Button("Scan QR code") {
                        self.isPresentingScanner.toggle()
                    }
                }
                else {
                    VStack {
                        VStack {
                            Button("Give Points") {
                                withAnimation {
                                    buttonsBar = .drinks
                                }
                            }
                            Button("Give Rewards") {
                                withAnimation{
                                    buttonsBar = .rewards
                                }
                            }
                        }
                        .font(.title)
                        .buttonStyle(.borderedProminent)
                        .tint(.beerOrange)
                        VStack {
                            switch buttonsBar {
                            case .drinks:
                                DynamicButtonsBar(elements: drinks)
                            case .rewards:
                                ProgressView()
                            case .none:
                                Text("Select an Action")
                            }
                        }
                    }
                }
                Spacer()
                Button("SignOut") {
                    withAnimation {
                        signOutAccount()
                    }
                }
                .foregroundStyle(.red.opacity(0.7))
            }
            .sheet(isPresented: $isPresentingScanner, content: {
                self.scannerSheet
            })
        }
    }
    @ViewBuilder
    func DynamicButtonsBar<T:Item>(elements: [T]) -> some View{
        HStack {
//            List {
                ForEach(elements, id: \.id) { element in
                    Button(element.name) {
//                        self.givePoints(points: element.value)
                        self.givePoints(element: element)
                    }
                }
//            }
        }
    }
    private func signOutAccount() {
        authViewModel.signOut()
    }
    private func givePoints(element: Item) {
        print("Adding \(element.value) points to \(scannedCode)")
        Task {
            do {
                let completed = try await Repositories.addMovement(drink: element, uid: scannedCode)
                if completed {
                    print("Movement edded")
                }
                else {
                    print("Something went wrong, we couldnt add the movement.")
                }
            }
            catch {
                print("Error after Repositories.addMovement")
            }
            
        }
    }
    private func getRewards() {
        
    }
    
}

#Preview {
    ScannerView()
}
