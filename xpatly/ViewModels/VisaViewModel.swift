//
//  File.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-04-09.
//

import Foundation
import Firebase
import FirebaseFirestore

class VisaViewModel: ObservableObject {
    @Published var yearsOfExperience: Int = 0
    @Published var preferredRegion: String?
    let db = Firestore.firestore()
    var countryViewModel = CountryViewModel()

    

    func getVisa(for country: Country) async throws -> [Visa] {
        let snapshot = try await db.collection("countries").document(country.id).collection("visa").getDocuments()
        return snapshot.documents.map {document in
            return Visa(type: document["type"] as? String ?? "", duration: document["duration"] as? Int ?? 0)
        }
    }
}
