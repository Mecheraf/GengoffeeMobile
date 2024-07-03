//
//  EventContent.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation
import SwiftUI


struct EventView: View {
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

#Preview {
    EventView()
}
