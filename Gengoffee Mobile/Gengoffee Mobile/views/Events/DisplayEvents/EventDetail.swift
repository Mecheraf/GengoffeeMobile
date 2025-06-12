//
//  EventDetail.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct EventDetail: View {
    var event:Event!
    @Binding var session:MainModel
    let defaults = UserDefaults.standard


    var body: some View {
        VStack(){
            EventDisplay(event:event)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        NavigationLink(destination:AddSingleRegisterView(session:$session)){
                            Text("Add User")
                        }
                    }
                }
            }
            if session.selectedTab == .checkIn || session.selectedTab == .createEvent  {
                RegisteredList(idEvent: event.id!, session: $session)
            }
            if session.selectedTab == .tables  {
                TablePlanView(session: $session, tables:checkTables(attendees: session.attendees), idEvent: event.id!)
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
