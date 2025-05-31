//
//  newTable.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/02/2025.
//

import Foundation
import SwiftUI


struct tableButtons:View {
    @Binding var tables:[TableModel]
    @Binding var session:MainModel
    var body : some View {
        HStack(spacing: 70) {
            newTableButton(tables: $tables)
            updateAttendeesTableButton(session: $session)
                .opacity(session.selectedTab == .tables ? 1 : 0)
        }
    }
}

struct newTableButton:View {
    @Binding var tables:[TableModel]
    var body : some View {
        Button("New table"){
            do {
                if(tables.count > 0) {
                    tables.append(createTable(numberTable: tables[tables.count-1].number+1))
                } else {
                    tables.append(createTable(numberTable:1))
                }
            }
        }
    }
}

struct updateAttendeesTableButton:View {
    @Binding var session:MainModel
    var body : some View {
        Button("Upload attendees"){
            do {
                updateTableAttendee(attendees: session.attendees, token: session.token, completion: { success in
                    print(success)
                })
            }
        }
    }
}

struct getAttendeesButton:View {
    @Binding  var attendees: [Attendee]
    @State var token:String
    @State var idEvent:Int

    var body : some View {
            Button("Update", action: {
                Task { //Need to update the attendees table before 
                    getAttendees(token: token, finished: { success in
                        Task {
                            getTemporaryAttendees(finished: { tempAttendees in
                                attendees = fusionListAttendees(arr1: tempAttendees , arr2: success)
                            })
                        }
                    })
                }
            })
    }
}


#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [], attendees: setAttendees, selectedTab: .tables, token:"")
        var body: some View {
            TablePlanView(session: $session)
        }
    }
    return Preview()
}
