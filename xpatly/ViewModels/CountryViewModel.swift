//
//  ViewModel.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class CountryViewModel: ObservableObject {
    @Published var allCountries = [Country]()
    @Published var selectedCountry: Country?
    @Published var preferredRegion: Region?
    @Published var yearsOfExperience: Int = 0
    var countriesFromPreferredRegion: [Country] = []
    let db = Firestore.firestore()
    
    func getAllCountries() async throws -> [Country] {
        let snapshot = try await db.collection("countries").getDocuments()
        
        var countries = [Country]()
        
        for document in snapshot.documents {
            var country = Country(
                name: document["name"] as? String ?? "",
                id: document.documentID,
                region: (document["region"] as? DocumentReference)!,
                countryCode: document["country_code"] as? String ?? "")
            
            let visas = try await getVisa(for: country)
            country.visas = visas
            countries.append(country)
        }
        
        return countries
    }
    func getVisa(for country: Country) async throws -> [Visa] {
        let snapshot = try await db.collection("countries").document(country.id).collection("visa").getDocuments()
        return snapshot.documents.map { document in
            return Visa(
                        type: document["type"] as? String ?? "",
                        duration: document["duration"] as? Int ?? 0,
                        experience: document["experience"] as? Int ?? 0)
        }
    }
    
    func filterCountriesFromRegion() throws -> [Country] {
        return allCountries.filter { $0.region?.documentID == preferredRegion!.id }
    }
    
    func filterCountriesByExperience() throws -> [Country] {
        let countriesByRegion = try filterCountriesFromRegion()
        var filteredCountries: [Country] = []
        for country in countriesByRegion {
            if let visas = country.visas {
                for visa in visas {
                    if visa.experience <= yearsOfExperience {
                        filteredCountries.append(country)
                        break // exit the loop when a visa meets the condition
                    }
                }
            }
        }
        print(filteredCountries)
        return filteredCountries
    }
    

}
