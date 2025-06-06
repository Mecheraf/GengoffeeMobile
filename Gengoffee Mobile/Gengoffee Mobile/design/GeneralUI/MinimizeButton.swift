//
//  MinimizeButton.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 12/02/2025.
//

import SwiftUI

struct minimizeButton: View {
    @Binding var isSelected:Bool
    
    var body:some View{
        Button(action: {
            isSelected = !isSelected
        }) {
            Image(systemName: isSelected ? "minus.circle":"plus.circle")
        }
        
    }
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [], attendees: setAttendees, selectedTab: .tables, token:"")
        @State var selectedUser:Int = 0

        var body: some View {
            WaitingList(session: $session, isSelected: false, selectedUser: $selectedUser)
        }
    }
    return Preview()
}

