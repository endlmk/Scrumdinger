//
//  NewScrumSheet.swift
//  Scrumdinger
//  
//  Created by endlmk on 2026/09/23
//  
//

import SwiftUI

struct NewScrumSheet: View {
    var body: some View {
        NavigationView {
            DetailEditView(scrum: nil)
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet()
    }
}
