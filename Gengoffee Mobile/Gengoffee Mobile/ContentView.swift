//
//  ContentView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 15/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var session: MainModel = MainModel(events: [blankEvent], attendees: sortNameAttendees(arr:getLocalAttendees()), selectedTab: .checkIn, token:"")
    let defaults = UserDefaults.standard
     
    var body: some View {
        NavigationStack {
            if(session.token == ""){
                LoginView(session: $session)
            } else {
                VStack {
                    switch session.selectedTab {
                    case .checkIn, .tables, .createEvent:
                        EventList(session: $session)
                    case .plus:
                        AddBulk(session: session)
                    case .settings:
                        Settings(session: $session)
                    }
                Spacer()
                FooterComponent(selectedTab: $session.selectedTab)
                .padding([.top], 20)
                }
                .onAppear() {
                    do {
                        if(session.token  != "1"){
                            getAttendees(token: session.token, finished: { success in
                                Task {
                                    getTemporaryAttendees(finished: { tempAttendees in
                                        session.attendees = fusionListAttendees(arr1: tempAttendees, arr2: success)
                                        Task {
                                            session.events = await assignAttendeesToEvents(limit:5, attendees: session.attendees)
                                        }
                                    })
                                }
                            })
                        }
                    }
                } //task
            }
            
        }
        .ignoresSafeArea(.keyboard)
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

