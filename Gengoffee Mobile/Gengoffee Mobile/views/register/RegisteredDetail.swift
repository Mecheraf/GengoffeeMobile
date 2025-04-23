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
    @Binding var attendees:[Attendee]
    let nationalities:[String] = ["jp", "fr", "en", "ハーフ", ""]

    
    var body: some View {
        VStack(){
            VStack{
                TextField(attendee.firstname, text: $attendee.firstname)
                TextField(attendee.lastname, text: $attendee.lastname)
            }.frame(width: 150, alignment: .center)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            Picker("Nationality", selection: $attendee.nationality){
                ForEach(nationalities, id: \.self) { value in
                    Text(value).tag(String?.some(value))
                }
            }
            .frame(width: 300)
            .pickerStyle(.segmented)
//            .onChange(of: attendee.nationality) {
//                addUpdatedAttendee(newAttendee: attendee, list: &attendees)
//            }
            
            Button{
                do {
                    updateUser(message: [attendee],
                           completion: { success in
                                            print(success)
                                        }
                    )
                    addUpdatedAttendee(newAttendee: attendee, list: &attendees)

                }
            }label: {designButton(icon: "person.fill.badge.plus", text: "Update")}
        }
        
    }
}

#Preview {
    struct Preview: View {
        @State var attendee:Attendee = steve
        @State private var updatedAttendees:[Attendee] = []
        var body: some View {
            RegisteredDetail(attendee: $attendee, attendees: $updatedAttendees)
        }
    }
    return Preview()
}
