//
//  AttendeesAlignement.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 12/02/2025.
//

import SwiftUI
import Foundation

struct AttendeesAlignement:View {
    @Binding var attendees: [Attendee]
    @Binding var selectedUser:Int
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: waitingGridLayout){
                    ForEach(Array(attendees.enumerated()), id:\.offset){ index, attendee in
                        if(attendee.tablenumber == 0 && attendee.paid > 0){
//                        if(attendee.tablenumber == 0){
                            AttendeePin(attendee:$attendees[index], selectedUser: $selectedUser)
                                .contextMenu(menuItems: {
                                    editAttendee(attendee: $attendees[index], attendees: $attendees)
                                    deleteAttendeeButton(attendee: attendee, attendees: $attendees)
                                    
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

        var body: some View {
            AttendeesAlignement(attendees: $attendees, selectedUser: $selectedUser)
        }
    }
    return Preview()
}
