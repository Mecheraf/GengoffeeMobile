//
//  RegisteredList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredList: View {
    @State var session:MainModel
    @State private var updatedAttendees:[Attendee] = []
    
    var body: some View {
        NavigationView{
            Section{
                List{
                    Section("Hello"){
                        ForEach(Array(session.attendees.enumerated()), id: \.offset){ index, attendee in
                            if (attendee.paid == 0) {
                                NavigationLink {
                                    RegisteredDetail(attendee:$session.attendees[index], attendees: $session.attendees)
                                }
                                label: {
                                    RegisteredRow(newAttendee: $session.attendees[index], updatedAttendees: $updatedAttendees)
                                }
                            }
                        }
                    }
                    Section("Paid"){
                        ForEach(Array(session.attendees.enumerated()), id: \.offset){ index, attendee in
                            if (attendee.paid > 0) {
                                NavigationLink {
                                    RegisteredDetail(attendee:$session.attendees[index], attendees: $session.attendees)
                                }
                                label: {
                                    RegisteredRow(newAttendee: $session.attendees[index], updatedAttendees: $updatedAttendees)
                                }
                            }
                        }
                    }
                }
            }
        }
        VStack {
            Button{
                do {
                    updateAttendee(message: updatedAttendees, token:session.token, completion: { success in
                        print(success)
                    })
                }
            }label: {
                VStack(spacing: 6) {
                    Image(systemName: "icloud.and.arrow.up.fill")
                    Text("Update check in")
                }.frame(maxWidth: .infinity)
            }
        }.onAppear()
    }
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: sortArray(arr:getLocalAttendees()), selectedTab: .checkIn, token:"")
        var body: some View {
            RegisteredList(session: session)
        }
    }
    return Preview()
}

