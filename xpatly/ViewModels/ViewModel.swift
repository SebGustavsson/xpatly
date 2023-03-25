//
//  ViewModel.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var list = [Country]()
    
    func getCountry() async throws -> [Country] {
           let db = Firestore.firestore()
           let snapshot = try await db.collection("countries").getDocuments()
           return snapshot.documents.map { document in
               return Country(name: document["name"] as? String ?? "", id: document.documentID)
           }
       }
}
