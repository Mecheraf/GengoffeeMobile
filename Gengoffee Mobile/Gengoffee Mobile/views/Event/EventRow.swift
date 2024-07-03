//
//  EventRow.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

var eventest = Event(
    id: 128,
    type: "jp",
    date: "2024-07-07T16:00:00.000Z",
    place: "Les Berthom",
    subscribe: 1,
    location: "PARIS"
)

var eventoust = Event(
    id: 128,
    type: "jp",
    date: "2024-07-07T16:00:00.000Z",
    place: "Food Hall Blast",
    subscribe: 1,
    location: "東京"
)
                     

struct EventRow: View {
    var event: Event

    var body: some View {
        HStack {
            Text(event.place)
            Text(event.location)
            Text(dateToSQLDate(event.date))
        }
    }
}


#Preview {
    Group{
        EventRow(event: eventest)
        EventRow(event: eventoust)

    }
}
