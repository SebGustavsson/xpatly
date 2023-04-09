//
//  ViewModel.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation
import Firebase
import FirebaseFirestore

class CountryViewModel: ObservableObject {
    @Published var list = [Country]()
    @Published var visaList = [Visa]()
    @Published var selectedCountry: Country? {
        didSet {
            print("Selected country: \(selectedCountry?.name ?? "nil")")
        }
    }
    
    func getCountry() async throws -> [Country] {
           let db = Firestore.firestore()
           let snapshot = try await db.collection("countries").getDocuments()
           return snapshot.documents.map { document in
               return Country(name: document["name"] as? String ?? "", id: document.documentID, region: document["region"] as? String ?? "", countryCode: document["country_code"] as? String ?? "")
           }
       }
    
    func getVisa(for country: Country) async throws -> [Visa] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("countries").document(country.id).collection("visa").getDocuments()
        return snapshot.documents.map {document in
            return Visa(type: document["type"] as? String ?? "", duration: document["duration"] as? Int ?? 0)
        }
    }
}
