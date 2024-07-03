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
    @Query private var items: [Item]
    @State private var attendees: [Attendee]?


    var body: some View {
        VStack{
            EventView()
        }
        FooterComponent()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
