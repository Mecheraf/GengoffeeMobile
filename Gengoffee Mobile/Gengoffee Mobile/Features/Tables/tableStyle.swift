//
//  tableStyle.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 30/01/2025.
//

import SwiftUI
import Foundation

struct TableStyle: View {
    @State var rectangleIsTargeted:Bool = false
    @Binding var attendees:[Attendee]
    @State var number:Int = 0
    @Binding var selectedUser:Int
    

    var body: some View {
        ZStack(){
            VStack{
                LazyVGrid(columns: tableGridLayout){
                    ForEach(Array(attendees.enumerated()), id:\.offset){ index,attendee in
                        if(attendee.tablenumber == number){
                            AttendeePin(attendee:$attendees[index], selectedUser: $selectedUser)
                            .contextMenu(menuItems:
                            {
                                NavigationLink(destination: RegisteredDetail(attendee: $attendees[index], attendees: $attendees)) {
                                    Text("Edit user")
                                    Image(systemName: "heart")
                                }
                                Button(action: {
                                    deleteDefaultsAttendee(id: attendee.idUser)
                                    attendees.remove(at: findIdUser(attendees: attendees, idUser: attendee.idUser))
                                })
                                {
                                    Text("Delete user")
                                    Image(systemName: "person.slash.fill")
                                }
                            })
                        }
                    }
                }.frame(width: 150)
                    .padding(.vertical)
            }
            .background{
                Color.white
                    .overlay(
                        Rectangle()
                        // we are lightening the rectange if someone is hovering over it with the expected payload
                        // to help users know that this is a target they can drop something onto
                            .foregroundStyle(
                                .secondary.opacity(0.1)
                            )
                            .border(Color.gengoffeeBlue, width: 1)
                            .cornerRadius(4)
                            .onTapGesture {
                                if(selectedUser != 0){
                                    attendees[findIdUser(attendees: attendees, idUser: selectedUser)].tablenumber = number
                                    selectedUser = 0
                                    let encoder = JSONEncoder()
                                    if let encoded = try? encoder.encode(attendees) {
                                        UserDefaults.standard.set(encoded, forKey: "attendees")

                                    }
                                }
                            }
                    )
            }
            TablePin(number: number)
        }
    }
}

//#Preview {
//    struct Preview: View {
//        @State var attendees:[Attendee] = setAttendees
//        var body: some View {
//            TablePlanView(attendees:$attendees, tables:[])
//        }
//    }
//    return Preview()
//}
