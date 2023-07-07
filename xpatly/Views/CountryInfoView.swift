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
    @Binding var weatherInfo: WeatherInfo?
    var imageNames: [String] = []
    
    
    init(country: Country, weatherInfo: Binding<WeatherInfo?>) {
           self.country = country
           self._weatherInfo = weatherInfo
           self.imageNames = getImages()
    }
    
    func getImages() -> [String] {
        var imageNames: [String] = []
        let imageAmount = 10
        for number in 1...imageAmount {
            let imageName = "\(country.name)-\(number)"
            imageNames.append(imageName)
        }
        return imageNames
    }
 
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    ForEach(imageNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .ignoresSafeArea()
                            .frame(height: 500)
                    }
                   
                }
                
                Section {
                    HStack {
                        Text(country.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(weatherInfo?.current.temp_c ?? 0)°")
                        AsyncImage(url: URL(string: "https:\(weatherInfo?.current.condition.icon ?? "")"))
                        Spacer()
                    }
                    
                    Text(country.description)
                        .padding(15)
                }
                Section {
                    Text("Available visas: ")
                        .font(.largeTitle)
                    ForEach(country.visas!, id: \.self) { visa in
                        Section {
                            Text(visa.type)
                            visa.duration > 1 ? Text("Duration: \(visa.duration) year") : Text("Duration: \(visa.duration) years")
                            Text("Required work experience: \(visa.experience) years")
                            if (visa.visaLink.count > 0) {
                                Link("Learn more", destination: URL(string: visa.visaLink)!)
                            }
                        }
                    }
                }
                Spacer()
                
            }
        }
    }
}
