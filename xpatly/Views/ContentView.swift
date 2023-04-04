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
    
    @ObservedObject var country = CountryViewModel()
    
    var body: some View {
            List (country.list) { country in
                NavigationLink(destination: CountryView(country: country)) {
                    Text(country.name)
                        .onTapGesture {
                            Task {
                                do {
                                    country.visaList = try await country.getVisa()
                                }
                            }
                        }
                }
            }
        .onAppear {
            Task {
                do {
                    country.list = try await country.getCountry()
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
