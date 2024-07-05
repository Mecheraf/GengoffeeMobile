//
//  EventList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

var events:[Event] = [
    Event(
        id: 128,
        type: "jp",
        date: "2024-07-07T16:00:00.000Z",
        place: "Les Berthom",
        subscribe: 1,
        location: "PARIS"
    ),
    Event(
        id: 129,
        type: "jp",
        date: "2024-07-07T16:00:00.000Z",
        place: "Food Hall Blast",
        subscribe: 1,
        location: "東京"
    )
]


struct EventList: View {
    var events: [Event]
    @Binding var selectedTab:FooterSelection
    
    var body: some View {
        NavigationSplitView {
            List(events, id: \.id) { event in
                NavigationLink {
                    EventDetail(event:event, selectedTab: $selectedTab)
                } label: {
                    EventRow(event: event)
                }
            }
            .navigationTitle("Events")
        } detail: {
            Text("Select a event")
        }
    }
}


#Preview {
    EventList(events: events, selectedTab: .constant(.tables))
}
