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
    @Published var allCountries = [Country]()
    @Published var selectedCountry: Country?
    @Published var preferredRegion: Region?
    var countriesFromPreferredRegion: [Country] = []
    let db = Firestore.firestore()
    
    func getAllCountries() async throws -> [Country] {
       let snapshot = try await db.collection("countries").getDocuments()
       return snapshot.documents.map { document in
           return Country(name: document["name"] as? String ?? "", id: document.documentID, region: (document["region"] as? DocumentReference)!, countryCode: document["country_code"] as? String ?? "")
       }
    }
    
    
    func filterCountriesFromRegion() throws -> [Country] {
        for country in allCountries {
            print(country.region!.path)
        }
        return allCountries.filter { $0.region?.path == preferredRegion!.name }
    }
    
}
