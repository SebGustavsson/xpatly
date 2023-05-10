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
        VStack(spacing: 10) {
            Image(countryImageURLs[country.name] ?? "default")
                .resizable()
                .ignoresSafeArea()
            
            Text(country.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(country.description)
            Spacer()
        }
    }
}

 struct CountryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyRef = Firestore.firestore().document("dummy/country")
        CountryInfoView(country: Country(name: "Malaysia", id: "3", region: dummyRef, countryCode: "MY", description: "String"))
    }
}
