//
//  TablePlan.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 28/01/2025.
//

import SwiftUI
import Foundation

@MainActor

struct TablePlanView: View {
    @Binding var session:MainModel
    @State var selectedUser:Int = 0
    @State var tables:[TableModel] = []
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    WaitingList(session:$session, selectedUser: $selectedUser)
                }
                Divider()
                NavigationStack{
                    tableButtons(tables: $tables, session: $session)
                    ScrollView(.vertical){
                        LazyVGrid(columns: tableGridLayout){
                            ForEach(tables, id:\.self.number){ table in
                                TableStyle(session:$session, number:table.number, selectedUser: $selectedUser)
                                    .contextMenu(menuItems:
                                                    {
                                        Button{
                                            do {
                                                if(checkTableUser(attendees: session.attendees, number: table.number)){
                                                    tables.remove(at:table.number - 1)
                                                }
                                            }
                                        } label: { designButton(icon: "minus.square", text: "Delete table")
                                        }
                                    })
                            }
                        }
                    }.refreshable {
                        if(session.token != "1") {
                            Task { //Need to update the attendees table before
                                getAttendees(token: session.token, finished: { attendees in
                                    Task {
                                        getTemporaryAttendees(finished: { tempAttendees in
                                            session.attendees = fusionListAttendees(arr1: tempAttendees , arr2: attendees)
                                            tables = checkTables(attendees: session.attendees)

                                        })
                                    }
                                })
                            }
                        } else {
                            print("Not connected")
                        }
                        
                    }
                    
                }
            }
        }
        .task {
            do {
                tables = checkTables(attendees: session.attendees)
            }
        }
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

