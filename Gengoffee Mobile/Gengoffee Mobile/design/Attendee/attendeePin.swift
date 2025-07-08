//
//  attendeePin.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 30/01/2025.
//

import SwiftUI

struct AttendeePin:View {
    @Binding var attendee:Attendee
    @Binding var selectedUser:Int
    @State var testList:[Attendee] = []
    @State var isPressing = false
    
    var body: some View {
        NavigationStack {
            let backgroundColor = attendee.changed == 0 ? Color.clear : selectColor(nat: attendee.nationality).opacity(0.6)
            Text(concatNamePin(name:attendee.firstname))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.Text)
                .frame(width: 50, height: 50)
                .font(.system(size: concatNamePin(name:attendee.firstname).count > 7 ? 9 : 11))
                .contentShape(Circle())
                .overlay(
                    Circle()
                        .stroke(selectColor(nat: attendee.nationality), lineWidth: 2)
                        .padding(1)
                        .background(
                            Circle()
                                .foregroundColor(selectedUser == attendee.idUser ? Color.gengoffeePink : backgroundColor)
                                .opacity(0.5)
                        )
                )
                .onTapGesture {
                    updateUser(selectedUser: &selectedUser, id: attendee.idUser)
                }
        }
    }
}
 
#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: setAttendees, selectedTab: .tables, token:"1")
        var body: some View {
            TablePlanView(session: $session)
        }
    }
    return Preview()
}
