//
//  NewScrumSheet.swift
//  Scrumdinger
//  
//  Created by endlmk on 2026/09/23
//  
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrumData = DailyScrum.Data()
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationView {
            DetailEditView(data: $newScrumData, saveEdits: { data in
                scrums.append(DailyScrum(data: data))
            })
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
    }
}
