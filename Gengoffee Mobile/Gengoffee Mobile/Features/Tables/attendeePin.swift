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
    
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        Text(concatNamePin(name:attendee.firstname))
            .multilineTextAlignment(.center)
            .foregroundColor(Color.black)
            .frame(width: 50, height: 50)
            .font(.system(size: concatNamePin(name:attendee.firstname).count > 7 ? 9 : 11))
            .contentShape(Circle())
            .overlay(
                Circle()
                    .stroke(selectColor(nat: attendee.nationality), lineWidth: 2)
                    .padding(1)
                    .background(
                        Circle()
                        .foregroundColor(selectedUser == attendee.idUser ? Color.gengoffeePink : Color.clear)
                        .opacity(0.5)
                    )
                    
            )
            .onTapGesture {
                updateUser(selectedUser: &selectedUser, id: attendee.idUser)
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.25)
                    .onEnded() { value in
                        updateUser(selectedUser: &selectedUser, id: attendee.idUser)
                        isPressing = value
                    }
            )
    }
}

#Preview {
    struct Preview: View {
        @State var attendees = setAttendees
        @State var attendee = vincent
        @State var selectedUser:Int = 0
        var body: some View {
            AttendeePin(attendee: $attendee, selectedUser: $selectedUser)
        }
    }
    return Preview()
}
