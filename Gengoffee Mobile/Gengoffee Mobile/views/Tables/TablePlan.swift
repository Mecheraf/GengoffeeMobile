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
        NavigationSplitView{
            VStack {
                HStack{
                    WaitingList(attendees:$session.attendees, selectedUser: $selectedUser)
                }
                Divider()
                NavigationView{
                    ScrollView(.vertical){
                        LazyVGrid(columns: tableGridLayout){
                            ForEach(tables, id:\.self.number){ table in
                                TableStyle(attendees: $session.attendees, number:table.number, selectedUser: $selectedUser)
                                    .contextMenu(menuItems:
                                    {
                                        Button{
                                            do {
                                                if(checkTableUser(attendees: session.attendees, number: table.number)){
                                                    tables.remove(at:table.number - 1)

                                                }
                                            }
                                        } label: { PrintButton(icon: "minus.square", text: "Delete table")
                                        }
                                    })
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                newTableButton(tables: $tables)
                                NavigationLink(destination:AddLocalRegisterView(session:session, localAttendees: $session.attendees)){
                                    Text("Add User")
                                }
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
        detail: {
            Text("Plan de table")
        }
        
    }
}

