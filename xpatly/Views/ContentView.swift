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
    
    @ObservedObject var model = ViewModel()


    var body: some View {
        List (model.list) { country in
            Text(country.name)
        }
        .onAppear {
            Task {
                do {
                    model.list = try await model.getCountry()
                } catch{
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
