//
//  tablePin.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/02/2025.
//

import SwiftUI

struct TablePin:View {
    @State var number:Int
    
    var body: some View {
        HStack{
            Text(String(number))
                .font(.system(size:22))
                .padding()
                .foregroundColor(Color.black)

        }
    }
}

#Preview {
    struct Preview: View {
        @State var attendees = setAttendees
        @State var selectedUser:Int = 0

        var body: some View {
            TableStyle(rectangleIsTargeted:false, attendees: $attendees, number:0, selectedUser: $selectedUser)
        }
    }
    return Preview()
}
