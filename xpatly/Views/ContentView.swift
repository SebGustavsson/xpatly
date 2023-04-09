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
    @State var selectedCountry: Country?

    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Nationality")) {
                    Picker(selection: $selectedCountry, label: Text("Select a country")) {
                        ForEach(countryViewModel.list) { country in
                            Text("\(country.flag) \(country.name)").tag(country as Country?)
                        }
                    }.onChange(of: selectedCountry) { value in
                        if let selectedCountry = value {
                            countryViewModel.selectedCountry = selectedCountry
                            print("selected country: \(selectedCountry)")
                        }
                    }
                }
                Section(header: Text("Years of work experience")) {
                    Stepper(value: $visaViewModel.yearsOfExperience, in: 0...30) {
                        Text("Years of experience: \(String($visaViewModel.yearsOfExperience.wrappedValue))")
                    }
                }
                Button("Print selected country") {
                                print("Selected country: \(String(describing: countryViewModel.selectedCountry))")
                            }
            }
         
        }
        .onAppear {
            Task {
                do {
                    countryViewModel.list = try await countryViewModel.getCountry()
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




