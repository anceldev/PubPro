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
    @Environment(ItemsViewModel.self) var itemsViewModel
    @State var isPresentingScanner = false
    @State var scannedCode: String = ""
    @State var confirmationGivePoints = false
    
    let drinks: [Drink]
    let rewards: [Reward]
    
    @State private var buttonsBar: ButtonsBar = .none
    
    enum ButtonsBar {
        case drinks
        case rewards
        case none
        
        var color: Color {
            switch self {
            case .drinks:
                Color.beerOrange
            case .rewards:
                Color.ppGreen
            case .none:
                Color.ppDarkWhite
            }
        }
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
                VStack {
                    TitleView(title: "Scanner", hasTable: false)
                }
                .padding(33)
                
                VStack {
                    Spacer()
                    if scannedCode.isEmpty {
                        Button("Scan QR code") {
                            self.isPresentingScanner.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    else {
                        VStack {
                            Spacer()
                            VStack {
                                Button("Give Points") {
                                    withAnimation {
                                        if !(buttonsBar == .drinks) {
                                            buttonsBar = .none
                                        }
                                        buttonsBar = .drinks
                                    }
                                }
                                .tint(.beerOrange)
                                Button("Give Rewards") {
                                    withAnimation{
                                        if !(buttonsBar == .rewards) {
                                            buttonsBar = .none
                                        }
                                        buttonsBar = .rewards
                                    }
                                }
                                .tint(.ppGreen)
                            }
                            .font(.title)
                            .buttonStyle(.borderedProminent)
                            
                            VStack {
                                switch buttonsBar {
                                case .drinks:
                                    DynamicButtonsBar(items: drinks)
                                case .rewards:
                                    DynamicButtonsBar(items: rewards)
                                case .none:
                                    Text("Select an Action")
                                }
                            }
                            Spacer()
                            Button("Reset Scanner", action: resetScanner)
                        }
                    }
                    Spacer()
                }
                .sheet(isPresented: $isPresentingScanner, content: {
                    self.scannerSheet
                })
            }
            .background(.ppDarkWhite)
        }
        .confirmationDialog("Succes", isPresented: $confirmationGivePoints) {
            Button("Ok") {
                self.confirmationGivePoints = false
            }
        } message: {
            Text("The points has been given succesfully to the user")
        }

    }
    @ViewBuilder
    func DynamicButtonsBar<T:Item>(items: [T]) -> some View{
        HStack {
            ForEach(items, id: \.id) { item in
                
                Button {
                    self.givePoints(for: item)
                } label: {
                    HStack{
                        Spacer()
                        Text(item.name)
                            .font(.system(size: 12))
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(buttonsBar.color)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 15)
    }
    private func givePoints(for item: Item) {
        print("Adding \(item.value) points to \(scannedCode)")
        Task {
            do {
                let completed = try await Repositories.addMovement(for: item, with: scannedCode, itemsList: itemsViewModel)
                if completed.0 {
                    print("Movement added")
                    self.confirmationGivePoints.toggle()
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
    private func resetScanner() {
        withAnimation {
            self.buttonsBar = .none
            self.scannedCode = ""
        }
    }
}

#Preview {
    ScannerView(drinks: [], rewards: [])
        .environment(ItemsViewModel())
}
