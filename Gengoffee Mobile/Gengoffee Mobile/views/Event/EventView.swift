//
//  EventContent.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation
import SwiftUI

struct EventView: View {
    @Binding var events: [Event]
    @Binding var selectedTab:FooterSelection
    @State var attendees:[Attendee] = []

    var body: some View {
        
        VStack{
            EventList(events: $events, selectedTab: $selectedTab)
        } //task
    } //body
} //struct

