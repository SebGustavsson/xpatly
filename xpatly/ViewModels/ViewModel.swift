//
//  ViewModel.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-03-20.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var list = [Country]()
    
    func getCountry() {
        let db = Firestore.firestore()
        db.collection("countries").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map {document in
                            return Country(name: document["name"] as? String ?? "", id: document.documentID)
                        }
                    }
                }
            }
            else {
                
            }
        }
    }
}
