//
//  AttendeesAlignement.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 12/02/2025.
//

import SwiftUI
import Foundation

struct AttendeesAlignement:View {
    @Binding var session: MainModel
    @Binding var selectedUser:Int
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: waitingGridLayout){
                    ForEach(Array(session.attendees.enumerated()), id:\.offset){ index, attendee in
                        if(attendee.tablenumber <= 0 && attendee.paid > 0){
//                        if(attendee.tablenumber == 0){
                            AttendeePin(attendee:$session.attendees[index], selectedUser: $selectedUser)
                                .contextMenu(menuItems: {
                                    editAttendee(attendee: $session.attendees[index], session: $session)
                                    deleteAttendeeButton(attendee: attendee, attendees: $session.attendees)
                                    
                                }
                                )
                        }
                    }
                }
            }
        }

    }
}


#Preview {
    struct Preview: View {
        @State var attendees = setAttendees
        @State var selectedUser:Int = 0
        @State var session:MainModel = MainModel(events: [blankEvent], attendees: sortNameAttendees(arr:getLocalAttendees()), selectedTab: .checkIn, token:"")
        var body: some View {
            AttendeesAlignement(session: $session, selectedUser: $selectedUser)
        }
    }
    return Preview()
}
