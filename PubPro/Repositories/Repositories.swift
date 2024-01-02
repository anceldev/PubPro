//
//  Repositories.swift
//  PubPro
//
//  Created by Ancel Dev account on 25/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class Repositories {
    private let drinksDB = Firestore.firestore().collection("drinksDB")
    
//    func fetchData<T: Codable>(nameDoc doc: String) async throws -> [T] {
//        let document = drinksDB.document(doc)
//        do {
//            let document = try await document.getDocument()
//            let dataList = try document.data(as: [T].self)
//            return dataList
//        }
//        catch {
//            fatalError("Can't fetch data list")
//        }
//    }
//    func fetchDrink() async throws -> Drink {
//        let document = drinksDB.document("drinks")
//        do {
//            let document = try await document.getDocument()
//            let drink = try document.data(as: Drink.self)
//            return drink
//        }
//        catch {
//            fatalError("Cant fetch one drink")
//        }
//    }
}
