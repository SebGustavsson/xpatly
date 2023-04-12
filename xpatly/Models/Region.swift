//
//  Region.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-04-10.
//

import Foundation

struct Region: Identifiable, Hashable {
    var id: String
    var name: String
    var regionCode: String
    var regionFlag: String {
        switch regionCode {
            case "Asia":
                return "🎋"
            case "EU":
                return "🇪🇺"
            default: return ""
        }
    }
}
