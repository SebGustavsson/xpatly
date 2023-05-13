//
//  CountryInfoView.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-05-01.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase


struct CountryInfoView: View {
    var country: Country
    let countryImageURLs = [
        "Malaysia": "photo-1508062878650-88b52897f298",
        "South Korea": "photo-1517154421773-0529f29ea451",
        "Indonesia": "photo-1501179691627-eeaa65ea017c"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image(countryImageURLs[country.name] ?? "default")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 500)
                
                Text(country.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(country.description)
                    .padding(15)
                Spacer()
            }
        }
    }
}

 struct CountryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyRef = Firestore.firestore().document("dummy/country")
        CountryInfoView(country: Country(name: "Malaysia", id: "3", region: dummyRef, countryCode: "MY", description: "Known for its technological advancements, South Korea is a perfect destination for digital nomads. With high-speed internet, efficient public transportation, and bustling cities like Seoul, you'll have access to a thriving tech scene and a rich cultural experience."))
    }
}
