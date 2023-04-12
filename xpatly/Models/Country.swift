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
    var visa: [Visa]?
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
 
    
    init(name: String, id: String, visa: [Visa]? = nil, region: DocumentReference, countryCode: String) {
        self.name = name
        self.id = id
        self.visa = visa
        self.region = region
        self.countryCode = countryCode
    }    
}
