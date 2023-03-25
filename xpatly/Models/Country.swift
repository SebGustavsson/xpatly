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
    var visa: Dictionary = [
        "duration": 0,
        "type": ""
    ] as [String : Any]
}
