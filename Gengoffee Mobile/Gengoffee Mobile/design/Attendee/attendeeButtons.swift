//
//  attendeeButtons.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 30/05/2025.
//

import SwiftUI

struct attendeeButtons:View {
    @Binding var tables:[TableModel]
    @Binding var session:MainModel
    var body : some View {
        HStack(spacing: 70) {
            newTableButton(tables: $tables)
            updateAttendeesTableButton(session: $session)
                .opacity(session.selectedTab == .tables ? 1 : 0)
        }
    }
}

struct editAttendee:View {
    @Binding var attendee:Attendee
    @Binding var attendees:[Attendee]
    var body : some View {
        NavigationLink(destination: RegisteredDetail(attendee: $attendee, attendees:$attendees, nat:attendee.nationality, isChanged:attendee.changed)) {
            Text("Edit user")
            Image(systemName: "heart")
        }
    }
}



struct deleteAttendeeButton:View {
    @State var attendee:Attendee
    @Binding var attendees:[Attendee]
    var body : some View {
        Button(action: {
            deleteDefaultsAttendee(id:  attendee.idUser)
            attendees.remove(at: findIdUser(attendees: attendees, idUser: attendee.idUser))
        })
        {
            Text("Delete user")
            Image(systemName: "person.slash.fill")
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
