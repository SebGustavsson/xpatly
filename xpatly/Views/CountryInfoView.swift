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
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    Image("\(country.name)-1")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(height: 500)
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

 struct CountryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyRef = Firestore.firestore().document("dummy/country")
        CountryInfoView(country: Country(name: "Malaysia", id: "3", visas: [Visa(type: "Digital nomad", duration: 1, experience: 0, description: "Malaysia offers a digital nomad visa program that allows remote workers to live and work in the country for 1 year. To qualify for the visa, applicants need to demonstrate a steady source of remote income, possess valid health insurance, and meet specific criteria set by the Malaysian government. ", visaLink: "<a href='https://mdec.my/derantau'>Tap to learn more</a>")], region: dummyRef, countryCode: "MY", description: "Known for its technological advancements, South Korea is a perfect destination for digital nomads. With high-speed internet, efficient public transportation, and bustling cities like Seoul, you'll have access to a thriving tech scene and a rich cultural experience." ), weatherInfo: .constant(nil))
    }
}
