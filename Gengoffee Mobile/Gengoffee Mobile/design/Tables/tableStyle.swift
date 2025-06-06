//
//  tableStyle.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 30/01/2025.
//

import SwiftUI
import Foundation

struct TableStyle: View {
    @Binding var session:MainModel
    @State var number:Int = 0
    @Binding var selectedUser:Int
    let maxWidth:CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 230 : 150

    var body: some View {
        ZStack(){
            VStack{
                LazyVGrid(columns: tableGridLayout){
                    ForEach(Array(session.attendees.enumerated()), id:\.offset){ index,attendee in
                        if(attendee.tablenumber == number && attendee.paid > 0){
                            AttendeePin(attendee:$session.attendees[index], selectedUser: $selectedUser)
                            .contextMenu(menuItems:
                            {
                                editAttendee(attendee: $session.attendees[index], session: $session)
                                deleteAttendeeButton(attendee: attendee, attendees: $session.attendees)
                            })
                        }
                    }
                }.frame(minWidth: 150, maxWidth: maxWidth)
                    .padding(.vertical)
            }
            .background{
                Color.white
                    .overlay(
                        Rectangle()
                            .foregroundStyle(
                                .secondary.opacity(0.1)
                            )
                            .border(Color.gengoffeeBlue, width: 1)
                            .cornerRadius(4)
                            .onTapGesture {
                                if(selectedUser != 0){
                                    if(session.attendees[findIdUser(attendees: session.attendees, idUser: selectedUser)].tablenumber != 0) {
                                        session.attendees[findIdUser(attendees: session.attendees, idUser: selectedUser)].changed = 1
                                    }
                                    session.attendees[findIdUser(attendees: session.attendees, idUser: selectedUser)].tablenumber = number
                                    selectedUser = 0
                                    let encoder = JSONEncoder()
                                    if let encoded = try? encoder.encode(session.attendees) {
                                        UserDefaults.standard.set(encoded, forKey: "attendees")
                                    }
                                }
                            }
                    )
                TablePin(number: number)
                    .position(x:12, y:12)
                ratioPin(attendees: $session.attendees, tableNumber: number)
                    .position(x:maxWidth - 15, y:12)
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
