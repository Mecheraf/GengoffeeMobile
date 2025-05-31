//
//  AddRegisterView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 22/06/2024.
//

import Foundation
import SwiftUI
import SwiftData


struct AddRegisterView: View {
    @State var session:MainModel
    @State var newUser:User = User()
    
    @State private var idEvent:Int = 0
    let nationalities = ["fr","en","jp", "ハーフ", "other"]
    let diets = ["None","Vegetarian","Vegan", "Halal"]
    
    var body: some View {
                VStack {
                    Form {
                        Picker("Select an event", selection: $idEvent){
                            ForEach(session.events, id: \.id) { event in
                                Text(event.place + " " + dateToSQLDate(event.date))
                                    .tag(event.id!)
                                    .foregroundStyle(selectColorEvent(type:event.type))
                            }
                        }
                        .pickerStyle(.inline)
                        
                        Section("User Informations") {
                            TextField("First name", text: $newUser.firstname)
                                .onTapGesture {
                                    hideKeyboard()
                                }
                            TextField("Last Name", text: $newUser.lastname)
                                .onTapGesture {
                                    hideKeyboard()
                                }
                            VStack {
                                Text("Nationality")
                                Picker("", selection: $newUser.nationality){
                                    ForEach(nationalities, id: \.self) { value in
                                        Text(String(value))
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                        }
                        Section("Language") {
                            HStack{
                                Text("French ")
                                Spacer()
                                Picker("", selection: $newUser.fr){
                                    ForEach(0...5, id: \.self) { value in
                                        Text(String(value))
                                    }
                                }
                                .pickerStyle(.segmented)
                                .frame(width: 220)
                            }
                            HStack{
                                Text("English")
                                Spacer()
                                Picker("", selection: $newUser.en){
                                    ForEach(0...5, id: \.self) { value in
                                        Text(String(value))
                                    }
                                }
                                .pickerStyle(.segmented)
                                .frame(width: 220)
                            }
                            HStack{
                                Text("Japanese")
                                Spacer()
                                Picker("", selection: $newUser.jp){
                                    ForEach(0...5, id: \.self) { value in
                                        Text(String(value))
                                    }
                                }
                                .pickerStyle(.segmented)
                                .frame(width: 220)
                            }
                        }
                        Section("More Informations") {
                            TextField("Mail", text: $newUser.mail)
                                .keyboardType(.emailAddress)
                            TextField("Phone", text: $newUser.phone)
                            VStack {
                                Text("Diet")
                                Picker("", selection: $newUser.diet){
                                    ForEach(diets, id: \.self) { value in
                                        Text(String(value))
                                    }
                                }
                                .pickerStyle(.segmented)
                                TextField("Other Diet", text: $newUser.diet)
                            }
                        }
                        Section("Age") {
                            DatePicker("Birth date:", selection: $newUser.birthdate, in: ...Date(), displayedComponents: .date).datePickerStyle(WheelDatePickerStyle()).font(.title)
                                .frame(height: 150)
                        }
                    } //Form
                    Button{
                        do {
                            let message = convertNewUser(user: newUser, idEvent: idEvent)
                            newUserToEvent(message: message, completion: { success in
                                print(success)
                            })
                        }
                    }label: {
                        VStack(spacing: 6) {
                            Image(systemName: "person.badge.plus.fill")
                            Text("Add User")
                        }.frame(maxWidth: .infinity)
                    }
                    .disabled(idEvent == 0)
                }
                .navigationTitle("Add User")
                .toolbar {
                    NavigationLink {
                        AddBulk(session: session)
                    } label: {
                        Text("Add Bulk")
                    }
            } //VStack
    } //body

} //struct

