//
//  RegisteredRow.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredRow: View {
    @Binding var newAttendee: Attendee
    @Binding var updatedAttendees:[Attendee]

    let prices:[Int] = [0, 10, 11]
    
    var body: some View {
        HStack {
            HStack {
                Text(newAttendee.firstname)
                Text(newAttendee.lastname)
            }
            .foregroundColor(selectColor(nat: newAttendee.nationality))

            Spacer()
            Picker("", selection: $newAttendee.paid){
                ForEach(prices, id: \.self) { value in
                    Text(String(value))
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
            .onChange(of: newAttendee.paid) {
                addUpdatedAttendee(newAttendee: newAttendee, list: &updatedAttendees)
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var attendees:[Attendee] = setAttendees
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"")
        var body: some View {
            RegisteredList(session: session)
        }
    }
    return Preview()
}
