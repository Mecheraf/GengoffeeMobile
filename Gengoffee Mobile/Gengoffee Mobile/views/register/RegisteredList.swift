//
//  RegisteredList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredList: View {
    var attendees: [Attendee]
    @State var addingAttendee:Bool = false
    
    var body: some View {
        NavigationSplitView {
            List(Array(attendees.enumerated()), id: \.offset) { index, attendee in
                NavigationLink {
                    RegisteredDetail(attendee:attendee)
                } label: {
                    RegisteredRow(attendee: attendee, paid:attendee.paid)
                }
            }.toolbar {
                ToolbarItem {
                    NavigationLink(destination: AddRegisterView(), isActive: $addingAttendee, label: {
                        Button(action: addAttendee) {
                            Label("Add Item", systemImage: "person.badge.plus")
                        }
                    })
                }
            }
        } detail: {
            Text("Select a event")
        }
    }
    
    func addAttendee(){
        print("Hello")
    }
}

