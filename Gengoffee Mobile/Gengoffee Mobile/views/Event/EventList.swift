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
    }
}


//#Preview {
//    struct Preview: View {
//        @State var session: MainModel = MainModel(events: [], attendees: [], selectedTab: .checkIn, token:"")
//        var body: some View {
//            EventList(session: $session)
//        }
//    }
//    return Preview()
//}

#Preview {
    struct Preview: View {
        var body: some View {
            ContentView()
        }
    }
    return Preview()
}
