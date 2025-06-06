//
//  RegisteredDetail.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredDetail: View {
    @Binding var attendee: Attendee
    @Binding var session: MainModel
    let nationalities:[String] = ["jp", "fr", "en", "ハーフ", ""]
    @State var nat:String = ""
    @State var isChanged:Int = 0
    
    @State var changedText:[String] = ["No", "Yes"]
    
    var body: some View {
        VStack(){
            
            VStack{
                TextField(attendee.firstname, text: $attendee.firstname)
                TextField(attendee.lastname, text: $attendee.lastname)
            }.frame(width: 150, alignment: .center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            List {
                Picker("Nationality", selection: $nat){
                    ForEach(nationalities, id: \.self) { value in
                        Text(value).tag(String?.some(value))
                    }
                }
                .frame(width: 300)
                .pickerStyle(.segmented)
                .onChange(of: nat) {
                    attendee.nationality = nat
                }
                
                Picker("Changed", selection: $isChanged){
                    ForEach(0...1, id: \.self) { value in
                        Text(changedText[value]).tag(value)
                    }
                }
                .frame(width: 300)
                .pickerStyle(.segmented)
                .onChange(of: isChanged){
                    attendee.changed = isChanged
                }
            }
            Button{
                do {
                    if(attendee.idUser > 0 ){
                        updateUser(message: [attendee],
                               completion: { success in
                                                print(success)
                                            }
                        )
                    } else {
                        updateTableAttendee(attendees: [attendee], token: session.token,
                               completion: { success in
                                                print(success)
                                            }
                        )
                    }
                    addUpdatedAttendee(newAttendee: attendee, list: &session.attendees)

                }
            }label: {designButton(icon: "person.fill.badge.plus", text: "Save")}
        }
        
    }
}

#Preview {
    struct Preview: View {
        @State var attendee:Attendee = steve
        @State var session:MainModel = MainModel(events: [blankEvent], attendees: sortNameAttendees(arr:getLocalAttendees()), selectedTab: .checkIn, token:"")
        var body: some View {
            RegisteredDetail(attendee: $attendee, session: $session)
        }
    }
    return Preview()
}
