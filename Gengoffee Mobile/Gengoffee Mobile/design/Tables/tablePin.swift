//
//  tablePin.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/02/2025.
//

import SwiftUI

struct TablePin:View {
    @State var number:Int
    @State var colorText = Color.Text
    @State var fontSize:CGFloat = 20
    var body: some View {
        Text(String(number))
            .font(.system(size:fontSize))
            .foregroundColor(colorText)
            
    }
}

struct ratioPin:View {
    @Binding var attendees:[Attendee]
    @State var colorText = Color.Text
    @State var fontSize:CGFloat = 14
    @State var tableNumber:Int = 0

    var body: some View {
        HStack(spacing: 1){
            Text(String(countTableUsers(attendees: attendees, type: ["fr"], tableNumber: tableNumber)))
                .font(.system(size:fontSize))
                .foregroundColor(Color.gengoffeeBlue)
            Text("/")
            Text(String(countTableUsers(attendees: attendees, type: ["jp", "ハーフ", "en"], tableNumber: tableNumber)))
                .font(.system(size:fontSize))
                .foregroundColor(Color.gengoffeeRed)
        }
    }
    
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [], attendees: setAttendees, selectedTab: .tables, token:"")
        @State var selectedUser:Int = 0

        var body: some View {
            TableStyle(session: $session, number:1, selectedUser: $selectedUser)
        }
    }
    return Preview()
}
