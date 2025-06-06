//
//  RegisteredList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredList: View {
    @State var idEvent:Int = 0
    @Binding var session:MainModel
    @State private var updatedAttendees:[Attendee] = []

    var body: some View {
        NavigationStack{
            let registerState:[Int] = session.selectedTab == .createEvent ? [-1, 0] : [0, 10, 11]
            Section{
                List{
                    Section("On list"){
                        ForEach(Array(session.attendees.enumerated()), id: \.offset){ index, attendee in
                            if (attendee.paid == registerState[0] && (attendee.idEvent == idEvent || attendee.idEvent == 0)) {
                                NavigationLink {
                                    RegisteredDetail(attendee:$session.attendees[index], session:$session, nat:session.attendees[index].nationality)
                                }
                                label: {
                                    RegisteredRow(newAttendee: $session.attendees[index],  updatedAttendees: $updatedAttendees, paid:session.attendees[index].paid, registerState:registerState)
                                }
                            }
                        }
                    }
                    Section(session.selectedTab == .createEvent ?  "Approved" : "Paid : \(countPaidUsers(attendees: session.attendees))"){
                        ForEach(Array(session.attendees.enumerated()), id: \.offset){ index, attendee in
                            if (registerState.contains(attendee.paid) && attendee.paid > registerState[0] && (attendee.idEvent == idEvent || attendee.idEvent == 0)) {
                                NavigationLink {
                                    RegisteredDetail(attendee:$session.attendees[index], session:$session, nat:session.attendees[index].nationality)
                                }
                                label: {
                                    RegisteredRow(newAttendee: $session.attendees[index], updatedAttendees: $updatedAttendees, paid:session.attendees[index].paid,
                                        registerState:registerState)
                                }
                            }
                        }
                    }
                }
            }
        }.refreshable {
            Task { //Need to update the attendees table before
                getAttendees(token: session.token, finished: { attendees in
                    Task {
                        getTemporaryAttendees(finished: { tempAttendees in
                            session.attendees = fusionListAttendees(arr1: tempAttendees , arr2: attendees)
                        })
                    }
                })
            }
        }
        VStack {
            Button{
                do {
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(session.attendees) {
                        UserDefaults.standard.set(encoded, forKey: "attendees")
                    }                    
                    updateTableAttendee(attendees: updatedAttendees, token:session.token, completion: { success in
                        print(success)
                    })
                }
            }label: {
                designButton(icon: "icloud.and.arrow.up.fill", text: "Save list")
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: sortNameAttendees(arr:getLocalAttendees()), selectedTab: .checkIn, token:"")
        var body: some View {
            RegisteredList(session: $session)
        }
    }
    return Preview()
}

