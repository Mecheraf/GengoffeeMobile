//
//  TableList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/07/2024.
//

import Foundation
import SwiftUI

struct TableList:View {
    @State var session:MainModel
    @State var attendees: [Attendee]
    @State var tables:[TableModel] = []
    
    var body: some View {
        NavigationSplitView {
            List(Array(tables.enumerated()), id: \.offset) { index, table in
                if(table.attendees.count > 0) {
                    NavigationLink {
                        AttendeesList(session: session, attendees: tables[index].attendees)
                    } label: {
                        TableRow(tableNumber: table.number, numberOfAttendees: table.attendees.count)
                    }
                }
            }
            .task {
                do {
                    tables = createTables(attendees: attendees)
                }
            }
        } detail: {
            Text("Select a table")
        }
    }
}
