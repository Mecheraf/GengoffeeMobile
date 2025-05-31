//
//  AddSingleRegister.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 14/03/2025.
//

import Foundation
import SwiftUI
import SwiftData


struct AddSingleRegisterView: View {
    @Binding var session:MainModel
    @FocusState private var keyboardFocused: Bool
    
    @State var newUser:Attendee = Attendee(
        idUser: -1,
        firstname: "",
        lastname: "",
        diet: Optional(""),
        paid: 0,
        idEvent: 0,
        tablenumber: 0,
        nationality: "fr",
        changed:0
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
            AddRegisterButtons(session: $session, newUser: $newUser)
                .padding(.top, 20)
        } //VStack
    } //body
} //struct

struct AddRegisterButtons: View {
    @Binding var session:MainModel
    @Binding var newUser:Attendee
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack(spacing: -100){
            Button{
                do {
                    newUser.paid = (session.selectedTab == .tables ? 10 : 0);
                    if(newUser.firstname.count > 0){
                        addLocalRegister(session: &session, newUser: newUser)
                    }
                }
            }label: { designButton(icon: "person.badge.plus.fill", text: "Add")
            }
            Button{
                do {
                    newUser.paid = (session.selectedTab == .tables ? 10 : 0);
                    if(newUser.firstname.count > 0){
                        addLocalRegister(session: &session, newUser: newUser)
                        dismiss()
                    }
                    
                }
            }label: { designButton(icon: "person.badge.plus.fill", text: "Add & Return")
            }
        }
        
    }
}



func addLocalRegister(session:inout MainModel, newUser:Attendee){
    session.attendees.append(
        Attendee(
            idUser: ((session.attendees.last?.idUser ?? 0) - 1),
            firstname: newUser.firstname,
            lastname: newUser.lastname,
            diet: Optional(""),
            paid: newUser.paid,
            idEvent: newUser.idEvent,
            tablenumber: 0,
            nationality: newUser.nationality,
            changed:newUser.changed
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
                paid: newUser.paid,
                idEvent: newUser.idEvent,
                tablenumber: 0,
                nationality: newUser.nationality,
                changed:newUser.changed
            )]
        ), token:session.token, completion: { success in
            print(success)
        })
    }
}

#Preview {
    struct Preview: View {
        @State var tmpAttendees:[Attendee] = []
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"")
        var body: some View {
            AddSingleRegisterView(session: $session)
        }
    }
    return Preview()
}
