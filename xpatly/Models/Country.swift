//
//  Countries.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation
import Firebase
import FirebaseFirestore


struct Country: Identifiable, Hashable, Equatable {
    var name: String
    var id: String
    var visas: [Visa]?
    var visaCollection: CollectionReference?
    var region: DocumentReference?
    var countryCode: String
    var flag: String {
        let base: UInt32 = 127397
        var flagString = ""
        for scalar in countryCode.unicodeScalars {
            flagString.append(String(UnicodeScalar(base + scalar.value)!))
        }
        return flagString
    }
    var description: String
    
 
    
    init(name: String, id: String, visas: [Visa]? = nil, region: DocumentReference, countryCode: String, description: String) {
        self.name = name
        self.id = id
        self.visas = visas
        self.region = region
        self.countryCode = countryCode
        self.description = description
    }    
}
