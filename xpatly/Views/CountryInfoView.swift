//
//  CountryInfoView.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-05-01.
//

import Foundation
import SwiftUI


struct CountryInfoView: View {
    var country: Country
    let countryImageURLs = [
        "Malaysia": "sadie-teper-WG-hXR1rLNk-unsplash",
        "South Korea": "photo-1517154421773-0529f29ea451",
        "Indonesia": "https://images.unsplash.com/photo-1501179691627-eeaa65ea017c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"
    ]
    
    var body: some View {
        VStack {
            Image(countryImageURLs[country.name] ?? "default")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
