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
    @StateObject private var regionViewModel = RegionViewModel()
    @State var chosenNationality: Country?
    @State var chosenRegion: Region?
    @State var showEligableCountries = false
    @State var weatherInfo: WeatherInfo?

    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Nationality")) {
                    Picker(selection: $chosenNationality, label: Text("What's your nationality?")) {
                        
                        ForEach(countryViewModel.allCountries) { country in
                            Text("\(country.flag) \(country.name)").tag(country as Country?)
                        }
                    
                    }.onChange(of: chosenNationality) { value in
                            countryViewModel.selectedCountry = chosenNationality
                    }
                }
                Section(header: Text("Years of work experience")) {
                    Stepper(value: $countryViewModel.yearsOfExperience, in: 0...30) {
                        Text("Years of experience: \(String($countryViewModel.yearsOfExperience.wrappedValue))")
                    }
                }
                Section(header: Text("Preferred region")) {
                    Picker(selection: $chosenRegion, label: Text("What's your preferred region?")) {
                        ForEach(regionViewModel.allRegions) { region in
                            Text("\(region.regionFlag)  \(region.name)").tag(region as Region?)
                        }.onChange(of: chosenRegion) { value in
                                countryViewModel.preferredRegion = chosenRegion
                        }
                    }
                  
                }
        }
            Button("Find countries") {
                Task {
                    do {
                        countryViewModel.selectedCountry = chosenNationality
                        countryViewModel.eligableCountries = try  countryViewModel.filterCountriesByExperience()
                        showEligableCountries = true

                    }
                    catch {
                        print("\(error)")
                    }
                }
            }.padding(10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
                .frame(maxWidth: .infinity, alignment: .center)
                .sheet(isPresented: $showEligableCountries) {
                        NavigationStack {
                            VStack {
                                Text("Here are some possible options")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                List {
                                    ForEach (countryViewModel.eligableCountries, id: \.self) { country in
                                        NavigationLink(destination: CountryInfoView(country: country, weatherInfo: $weatherInfo)) {
                                            Text("\(country.flag) \(country.name)")
                                        }.onTapGesture {
                                            print("hi")
                                            Task {
                                                do {
                                                    weatherInfo = try await countryViewModel.getCountryWeather(_countryName: country.name)

                                                } catch {
                                                    print(error)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                    }
                }
        }
        .onAppear {
            Task {
                do {
                    countryViewModel.allCountries = try await countryViewModel.getAllCountries()
                    let regions = try await regionViewModel.getAllRegions()
                        regionViewModel.allRegions = regions
                        chosenRegion = regionViewModel.allRegions.first
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




