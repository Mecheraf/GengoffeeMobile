//
//  RegisteredList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredList: View {
    @State var attendees: [Attendee]
    @State var addingAttendee:Bool = false
    
    var body: some View {
        NavigationSplitView {
            List(Array(attendees.enumerated()), id: \.offset) { index, attendee in
                NavigationLink {
                    RegisteredDetail(attendee:attendee)
                } label: {
                    RegisteredRow(attendee: attendee, newAttendee: $attendees[index])
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
//            Button{
//                do {
//                    print(attendees)
//                }
//            }label: {
//                VStack(spacing: 6) {
//                    Image(systemName: "icloud.and.arrow.up")
//                    Text("Print")
//                }.frame(maxWidth: .infinity)
//            }

        }
    }
    
    func addAttendee(){
        print("Hello")
    }
}

#Preview {
    EventView(selectedTab: .constant(.checkIn))
}
