//
//  ContentView.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-01-14.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct ContentView: View {
    
    @ObservedObject var countryViewModel = CountryViewModel()
    @ObservedObject var visaViewModel = VisaViewModel()
    @State var chosenNationality: Country?
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Nationality")) {
                    Picker(selection: $chosenNationality, label: Text("What's your nationality?")) {
                        ForEach(countryViewModel.list) { country in
                            Text("\(country.flag) \(country.name)").tag(country as Country?)
                        }
                    }.onChange(of: chosenNationality) { value in
                        if let chosenNationality = value {
                            countryViewModel.selectedCountry = chosenNationality
                        }
                    }
                }
                Section(header: Text("Years of work experience")) {
                    Stepper(value: $visaViewModel.yearsOfExperience, in: 0...30) {
                        Text("Years of experience: \(String($visaViewModel.yearsOfExperience.wrappedValue))")
                    }
                }
                Section(header: Text("Preferred region")) {
                    Picker(selection: $visaViewModel.preferredRegion, label: Text("What's your preferred region?")) {
                        
                    }
                }
            }
         
        }
        .onAppear {
            Task {
                do {
                    countryViewModel.list = try await countryViewModel.getAllCountries()
                } catch {
                    print("\(error)")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




