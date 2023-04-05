//
//  CountryView.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-04-04.
//

import Foundation
import SwiftUI

struct CountryView: View {
    let country: Country
    let visaList: [Visa]?
    
    var body: some View {
        VStack {
            Text(country.name)
            if let visaList = visaList {
                List(visaList, id: \.self) { visa in
                    Text(visa.type)
                }
            }
        }
    }
}
