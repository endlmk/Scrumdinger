//
//  ScrumdingerApp.swift
//  Scrumdinger
//  
//  Created by endlmk on 2022/08/30
//  
//

import SwiftUI
import SwiftData

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView()
            }
        }
        .modelContainer(for: DailyScrum.self)
    }
}
