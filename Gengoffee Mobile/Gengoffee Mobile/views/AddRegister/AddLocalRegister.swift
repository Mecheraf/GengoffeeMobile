//
//  AddLocalRegister.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 14/03/2025.
//

import Foundation
import SwiftUI
import SwiftData


struct AddLocalRegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var session:MainModel
    @FocusState private var keyboardFocused: Bool
    @State var newUser:Attendee = Attendee(
        idUser: -1,
        firstname: "",
        lastname: "",
        diet: Optional(""),
        paid: 10,
        idEvent: 0,
        tablenumber: 0,
        nationality: "fr"
    )
    
    @State private var idEvent:Int = 0
    let nationalities = ["fr","en","jp", "ハーフ", "other"]
    
    var body: some View {
        VStack {
            Section("User Informations") {
                TextField("Name", text: $newUser.firstname)
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                Picker("", selection: $newUser.nationality){
                    ForEach(nationalities, id: \.self) { value in
                        Text(String(value))
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Button{
                do {
                    if(newUser.firstname.count > 0){
                        session.attendees.append(
                            Attendee(
                                idUser: ((session.attendees.last?.idUser ?? 0) - 1),
                                firstname: newUser.firstname,
                                lastname: newUser.lastname,
                                diet: Optional(""),
                                paid: newUser.paid,
                                idEvent: newUser.idEvent,
                                tablenumber: 0,
                                nationality: newUser.nationality
                            )
                        )
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(session.attendees) {
                            UserDefaults.standard.set(encoded, forKey: "attendees")
                        }
                        if(session.token != "1"){
                            addTemporaryAttendee(message: temporaryAttendees(
                                type:2,
                                attendees:[Attendee(
                                    idUser: ((session.attendees.last?.idUser ?? 0) - 1),
                                    firstname: newUser.firstname,
                                    lastname: newUser.lastname,
                                    diet: Optional(""),
                                    paid: 10,
                                    idEvent: newUser.idEvent,
                                    tablenumber: 0,
                                    nationality: newUser.nationality
                                )]
                            ), token:session.token, completion: { success in
                                print(success)
                            })
                        }
                        dismiss()
                    }
                    
                }
            }label: {
                VStack(spacing: 6) {
                    Image(systemName: "person.badge.plus.fill")
                    Text("Add User")
                }.frame(maxWidth: .infinity)
            }
        } //VStack
    } //body

} //struct

#Preview {
    struct Preview: View {
        @State var tmpAttendees:[Attendee] = []
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"")
        var body: some View {
            AddLocalRegisterView(session: $session)
        }
    }
    return Preview()
}
