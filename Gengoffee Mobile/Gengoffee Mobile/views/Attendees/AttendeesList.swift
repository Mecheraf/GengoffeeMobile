//
//  AttendeesList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI

struct AttendeesList: View {
    @State var attendees: [Attendee]
    @State var addingAttendee:Bool = false
    
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
            Text("Select a event")
        }
        VStack {
            Button{
                do {
                    let message = [
                        "attendees": attendees
                    ]
                    updateAttendee(message: message, completion: { success in
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

#Preview {
    EventView(selectedTab: .constant(.tables))
}
