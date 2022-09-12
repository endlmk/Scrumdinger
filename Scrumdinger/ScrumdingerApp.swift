//
//  ScrumdingerApp.swift
//  Scrumdinger
//  
//  Created by endlmk on 2022/08/30
//  
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.sampleData)
            }
        }
    }
}
