//
//  AttendeesAlignement.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 12/02/2025.
//

import SwiftUI
import Foundation

struct AttendeesAlignement:View {
    @Binding var session: MainModel
    @Binding var selectedUser:Int
    @State var idEvent:Int = 0

    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: waitingGridLayout){
                    ForEach(Array(session.attendees.enumerated()), id:\.offset){ index, attendee in
                        if(attendee.idEvent == 0 || attendee.idEvent == idEvent){
                            if(attendee.tablenumber <= 0 && attendee.paid > 0){
                                AttendeePin(attendee:$session.attendees[index], selectedUser: $selectedUser)
                                .contextMenu(menuItems: {
                                    editAttendee(attendee: $session.attendees[index], session: $session)
                                    deleteAttendeeButton(attendee: attendee, attendees: $session.attendees)
                                    
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .onTapGesture {
                if(selectedUser != 0){
                    session.attendees[findIdUser(attendees: session.attendees, idUser: selectedUser)].tablenumber = -1
                    selectedUser = 0
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(session.attendees) {
                        UserDefaults.standard.set(encoded, forKey: "attendees")
                    }
                }
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
