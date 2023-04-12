//
//  RegionViewModel.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-04-12.
//

import Foundation
import Firebase
import FirebaseFirestore

class RegionViewModel: ObservableObject {
    @Published var allRegions: [Region] = []
    let db = Firestore.firestore()
    
    func getAllRegions() async throws -> [Region] {
        let snapshot = try await db.collection("regions").getDocuments()
        return snapshot.documents.map { document in
            return Region( id: document.documentID, name: document["name"] as? String ?? "", regionCode: document["region_code"] as? String ?? "")
        }
    }
    
    
    
}
