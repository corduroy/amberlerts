//
//  AmberlertsApp.swift
//  Amberlerts-watch WatchKit Extension
//
//  Created by Joshua McKinnon on 8/12/21.
//

import SwiftUI

@main
struct AmberlertsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
