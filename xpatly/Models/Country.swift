//
//  Countries.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation

struct Country: Identifiable {
    var name: String
    var id: String
    var visa: [Visa]?
    
    init(name: String, id: String, visa: [Visa]? = nil) {
        self.name = name
        self.id = id
        self.visa = visa
    }
}
