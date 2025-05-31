//
//  AttendeesList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI

struct AttendeesList: View {
    @State var session:MainModel

    @State var attendees: [Attendee]
    
    var body: some View {
        NavigationSplitView {
            List(Array(attendees.enumerated()), id: \.offset) { index, attendee in
                NavigationLink {
                    AttendeesDetails(attendee:attendee)
                } label: {
                    AttendeesRow(attendee: attendee, newAttendee: $attendees[index])
                }
            }
        } detail: {
            Text("Select an attendee")
        }
        VStack {
            Button{
                do {
                    updateTableAttendee(attendees: attendees, token:session.token, completion: { success in
                        print(success)
                    })
                }
            }label: {
                VStack(spacing: 6) {
                    Image(systemName: "icloud.and.arrow.up.fill")
                    Text("Update")
                }.frame(maxWidth: .infinity)
            }
        }
    }

}
