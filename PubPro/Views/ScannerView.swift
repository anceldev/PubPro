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
    
    let drinks: [Drink]
    let rewards: [Reward]
    
    //    var drinks: [Drink] = [
    //        Drink(name: "Cóctel", descriptionItem: "Description of cóctel", value: 50),
    //        Drink(name: "Cachimba", descriptionItem: "Description of cachimba", value: 100),
    //        Drink(name: "Combinado", descriptionItem: "Description of combinado", value: 70)
    //    ]
    
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
                        .buttonStyle(.borderedProminent)
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
                                    DynamicButtonsBar(items: drinks)
                                case .rewards:
                                    DynamicButtonsBar(items: rewards)
                                case .none:
                                    Text("Select an Action")
                                }
                            }
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
    }
    @ViewBuilder
    func DynamicButtonsBar<T:Item>(items: [T]) -> some View{
        HStack {
            ForEach(items, id: \.id) { item in
                Button(item.name) {
                    self.givePoints(for: item)
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 15)
    }
    private func givePoints(for item: Item) {
        print("Adding \(item.value) points to \(scannedCode)")
        Task {
            do {
                let completed = try await Repositories.addMovement(for: item, with: scannedCode)
                if completed {
                    print("Movement added")
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
}

#Preview {
    ScannerView(drinks: [], rewards: [])
}
