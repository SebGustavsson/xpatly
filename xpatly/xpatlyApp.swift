//
//  xpatlyApp.swift
//  xpatly
//
//  Created by Sebastian Gustavsson on 2023-01-14.
//

import SwiftUI
import Firebase


@main   
struct xpatlyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct NavigationPrimary_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
