//
//  Countries.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation

struct Country: Identifiable, Hashable, Equatable {
    var name: String
    var id: String
    var visa: [Visa]?
    var region: String
    var countryCode: String
    var flag: String {
        let base: UInt32 = 127397
        var flagString = ""
        for scalar in countryCode.unicodeScalars {
            flagString.append(String(UnicodeScalar(base + scalar.value)!))
        }
        return flagString
    }
 
    
    init(name: String, id: String, visa: [Visa]? = nil, region: String, countryCode: String) {
        self.name = name
        self.id = id
        self.visa = visa
        self.region = region
        self.countryCode = countryCode
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
}
