//
//  AttendeesRow.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI

struct AttendeesRow: View {
    @State var attendee: Attendee
    @Binding var newAttendee: Attendee

    let tables:[Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    var body: some View {
        HStack {
            Text(attendee.firstname)
            Text(attendee.lastname.first?.description ?? "")
            Spacer()
            Picker("", selection: $newAttendee.tablenumber){
                ForEach(tables, id: \.self) { value in
                    Text(String(value))
                }
            }
            .frame(width: 150)
        }
    }
}

//#Preview {
//    EventView(selectedTab: .constant(.tables))
//}
