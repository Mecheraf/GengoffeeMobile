//
//  ContentView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 15/06/2024.
//

import SwiftUI
import SwiftData


var globalAPI = APIModel()

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var session: MainModel = MainModel(events: [blankEvent], attendees: sortArray(arr:getLocalAttendees()), selectedTab: .checkIn, token:"")
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            if(session.token.count == 0){
                LoginView(session: $session)
            } else {
                VStack {
                    switch session.selectedTab {
                    case .checkIn, .tables:
                        EventList(session: $session)
                    case .plus:
                        AddRegisterView(session: session)
                    case .createEvent:
                        CreateEventView(session: session)
                    case .settings:
                        Settings(session: $session)
                    default:
                        EventList(session: $session)
                    }
                Spacer()
                    FooterComponent(selectedTab: $session.selectedTab)
                    .padding([.top], 20)
                }
                .task {
                    do {
                        if(session.token  != "1"){
                            getAttendees(token: session.token, finished: { success in
                                Task {
                                    session.attendees = sortArray(arr:fusionListAttendees(arr1: try await getTemporaryAttendees(), arr2: success))
                                    session.events = await assignAttendeesToEvents(limit:5, attendees: session.attendees)
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

