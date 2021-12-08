//
//  AmberlertsApp.swift
//  Shared
//
//  Created by Joshua McKinnon on 3/12/21.
//

import SwiftUI

@main
struct AmberlertsApp: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
