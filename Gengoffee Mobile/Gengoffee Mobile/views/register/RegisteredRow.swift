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
    @State var paid:Int = 0

    @State var registerState:[Int] = []
    
    var body: some View {
        HStack {
            HStack {
                Text(newAttendee.firstname)
                Text(newAttendee.lastname)
            }
            .foregroundColor(selectColor(nat: newAttendee.nationality))

            Spacer()
            Picker("", selection: $paid){
                ForEach(registerState, id: \.self) { value in
                    Text(String(value))
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
            .onChange(of: paid) {
                newAttendee.paid = paid
                addUpdatedAttendee(newAttendee: newAttendee, list: &updatedAttendees)
            }

        }
    }
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: setAttendees, selectedTab: .tables, token:"")
        var body: some View {
            RegisteredList(idEvent: 0, session: $session)
        }
    }
    return Preview()
}
