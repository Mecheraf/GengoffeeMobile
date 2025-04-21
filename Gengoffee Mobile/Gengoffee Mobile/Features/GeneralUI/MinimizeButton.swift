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
        @State var attendees = setAttendees
        @State var selectedUser:Int = 0

        var body: some View {
            WaitingList(attendees: $attendees, isSelected: false, selectedUser: $selectedUser)
        }
    }
    return Preview()
}

