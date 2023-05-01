//
//  File.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-04-09.
//

import Foundation
import Firebase
import FirebaseFirestore

class VisaViewModel: ObservableObject {
    let db = Firestore.firestore()
    var countryViewModel = CountryViewModel()

    
}
