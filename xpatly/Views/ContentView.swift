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
    
    @ObservedObject var countryModel = CountryViewModel()
    
    var body: some View {
            List (countryModel.list) { country in
                NavigationLink(destination: CountryView(country: country)) {
                    Text(country.name)
                        .onTapGesture {
                            Task {
                                do {
                                    countryModel.visaList = try await countryModel.getVisa(for: <#T##Country#>)
                                }
                            }
                        }
                }
            }
        .onAppear {
            Task {
                do {
                    countryModel.list = try await countryModel.getCountry()
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
