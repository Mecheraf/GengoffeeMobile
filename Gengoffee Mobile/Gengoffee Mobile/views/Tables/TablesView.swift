//
//  TablesView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI


struct TablesView: View {
    @State private var events: [Event]?
    @State private var attendees: [Attendee]?

    var body: some View {
        
        VStack{
            if let events {
                EventList(events: events)
            } // if var events
        }
        .task {
            do {
                attendees = try await getAttendees()
                events = await assignAttendeesToEvents(limit:5, attendees: attendees!)
            } catch {
                events = []
                attendees = []
            }
        } //task
    } //body
} //struct
