//
//  EventDetail.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

var event = Event(
    id: 128,
    type: "jp",
    date: "2024-07-07T16:00:00.000Z",
    place: "Les Berthom",
    subscribe: 1,
    location: "PARIS"
)

struct EventDetail: View {
    var event: Event!
    @Binding var selectedTab:FooterSelection

    
    var body: some View {
        VStack(){
            Text(event.place)
            Text(event.location)
            Text(dateToSQLDate(event.date))
            if selectedTab == .checkIn  {
                RegisteredList(attendees: event.attendees ?? [])
            }
            if selectedTab == .tables  {
                AttendeesList(attendees: filterAttendees(attendees: event.attendees ?? []))
            }
        }
    }
}

#Preview {
    EventDetail(event:event, selectedTab: .constant(.tables))
}
