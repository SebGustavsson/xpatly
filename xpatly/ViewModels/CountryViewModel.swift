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
    @ObservedObject var regionViewModel = RegionViewModel()
    @Published var yearsOfExperience: Int = 0
    @Published var weatherInfos: WeatherInfo?
    var countriesFromPreferredRegion: [Country] = []
    var eligableCountries: [Country] = []
    let db = Firestore.firestore()


    
    // fetches an array containing each countries visas
    func getVisa(for country: Country) async throws -> [Visa] {
        let snapshot = try await db.collection("countries").document(country.id).collection("visa").getDocuments()
        return snapshot.documents.map { document in
            return Visa(
                        type: document["type"] as? String ?? "",
                        duration: document["duration"] as? Int ?? 0,
                        experience: document["experience"] as? Int ?? 0,
                        description: document["description"] as? String ?? "",
                        visaLink: document["visa_link"] as? String ?? ""
            )
        }
    }
    
    
    func getAllCountries() async throws -> [Country] {
        let snapshot = try await db.collection("countries").getDocuments()
        
        var countries = [Country]()
        
        for document in snapshot.documents {
            var country = Country(
                name: document["name"] as? String ?? "",
                id: document.documentID,
                region: (document["region"] as? DocumentReference)!,
                countryCode: document["country_code"] as? String ?? "",
                description: document["description"] as? String ?? "")
            
            let visas = try await getVisa(for: country)
            country.visas = visas
            countries.append(country)
        }
        print(Locale.current.language.region?.identifier)
        return countries
    }
    
    func filterCountriesFromRegion() throws -> [Country] {
        selectedCountry == nil ? selectedCountry = allCountries.first : nil
        return allCountries.filter { $0.region?.documentID == preferredRegion!.id && $0.id != selectedCountry!.id}
    }
    
    // returns countries that have a visa with a required work experience matching the users
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
        return filteredCountries
    }
    
    
    
    func getCountryWeather(_countryName: String) async throws -> WeatherInfo {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(Keys.weatherAPIKey)&q=\(_countryName)&aqi=no") else {
            print("error")
            throw WeatherAPIError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(WeatherInfo.self, from: data) {
                weatherInfos = decodedResponse
            }
        } catch {
            print(error)
        }
        return weatherInfos!
    }
    
    enum WeatherAPIError: Error {
        case invalidURL
        case decodingFailed
        case networkError(Error)
    }
    

}
