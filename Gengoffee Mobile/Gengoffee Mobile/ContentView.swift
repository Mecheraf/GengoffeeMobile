//
//  ContentView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 15/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var selectedTab:FooterSelection = .checkIn
    @Query private var items: [Item]
    @State private var attendees: [Attendee]?


    var body: some View {
        VStack{
            if selectedTab == .checkIn{
                EventView(selectedTab: $selectedTab)
            }
            if selectedTab == .plus {
                AddRegisterView()
            }
            if selectedTab == .tables{
                EventView(selectedTab: $selectedTab)
            }
            if selectedTab == .createEvent{
                CreateEventView()
            }
        }
        Spacer()
        FooterComponent(selectedTab: $selectedTab )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
