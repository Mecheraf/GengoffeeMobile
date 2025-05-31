//
//  EventList.swift
//  ] Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI



struct EventList: View {
    @Binding var session:MainModel
    
    var body: some View {
        VStack {
            List(session.events, id: \.id) { event in
                if(session.events.count > 0){
                    NavigationLink {
                        EventDetail(event:event, session:$session)
                    } label: {
                        EventRow(event: event)
                    }
                    
                } else if (session.events.count == 0 && session.selectedTab == .tables) {
                    NavigationLink {
                        EventDetail(event:blankEvent,  session:$session)
                    } label: {
                        EventRow(event: blankEvent)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CreateEventView(session: session)
                } label : {
                    Text("Create event")
                        .frame(height: 20)
                }.opacity(session.selectedTab == .createEvent ? 1 : 0)
            }
        }
    }
}


#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: sortNameAttendees(arr:getLocalAttendees()), selectedTab: .createEvent, token:"")
        var body: some View {
            EventList(session: $session)
        }
    }
    return Preview()
}

//#Preview {
//    struct Preview: View {
//        var body: some View {
//            ContentView()
//        }
//    }
//    return Preview()
//}
