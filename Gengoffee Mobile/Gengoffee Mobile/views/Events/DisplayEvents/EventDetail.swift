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
                RegisteredList(idEvent:event.id!, session: $session)
            }
            if session.selectedTab == .tables  {
                TablePlanView(session: $session, tables:[])
            }
        }.task{
            do {
                if(session.token  != "1"){
                    getAttendees(token: session.token, finished: { attendees in
                        Task {
                            getTemporaryAttendees(finished: { tempAttendees in
                                session.attendees = fusionListAttendees(arr1: tempAttendees , arr2: attendees)
                            })
                            session.events = await assignAttendeesToEvents(limit:5, attendees: session.attendees)
                        }
                    })
                } else {
                    if let data = defaults.object(forKey: "attendees") as? Data {
                        let decoder = JSONDecoder()
                        if let savedData = try? decoder.decode([Attendee].self, from: data) {
                            session.attendees = savedData
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
