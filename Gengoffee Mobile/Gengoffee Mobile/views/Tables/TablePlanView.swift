//
//  TablePlanView.swift
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
    @State var idEvent:Int = 0
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    WaitingList(session:$session, selectedUser: $selectedUser, idEvent: idEvent)
                }
                Divider()
                NavigationStack{
                    tableButtons(tables: $tables, session: $session)
                    ScrollView(.vertical){
                        LazyVGrid(columns: tableGridLayout){
                            ForEach(tables, id:\.self.number){ table in
                                TableStyle(session:$session, number:table.number, selectedUser: $selectedUser, idEvent: idEvent)
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
                        tables = checkTables(attendees: session.attendees.filter({ $0.paid > 0}))

                        if(session.token == "1"){
                            session.attendees = getLocalAttendees()
                        } else {
                            getAttendees(token: session.token, finished: { attendees in
                                Task {
                                    getTemporaryAttendees(finished: { tempAttendees in
                                        session.attendees = fusionListAttendees(arr1: tempAttendees , arr2: attendees)
                                    })
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            ContentView()
        }
    }
    return Preview()
}

