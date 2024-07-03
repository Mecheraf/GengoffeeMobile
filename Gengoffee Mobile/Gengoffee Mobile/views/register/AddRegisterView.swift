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
    
    var idEvent: Int = 127
    
    @State private var firstname: String = "Daigo"
    @State private var lastname: String = "Lopes"
    @State private var nationality: String = "ハーフ"
    
    @State private var birthDate = Date()
    @State private var age: DateComponents = DateComponents()
    
    @State private var french: Int = 5
    @State private var english: Int = 3
    @State private var japanese: Int = 5
    
    @State private var phone: String = "061212"
    @State private var mail: String = "daig@lopes.com"
    @State private var diet: String = "None"

    let nationalities = ["fr","en","jp", "ハーフ", "other"]
    let diets = ["None","Vegetarian","Vegan", "Halal"]

    var body: some View {
        VStack {
            
            Form {
                Section("User Informations") {
                    TextField("First name", text: $firstname)
                    TextField("Last Name", text: $lastname)
                    VStack {
                        Text("Nationality")
                        Picker("", selection: $nationality){
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
                        Picker("", selection: $french){
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
                        Picker("", selection: $english){
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
                        Picker("", selection: $japanese){
                            ForEach(0...5, id: \.self) { value in
                                Text(String(value))
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 220)
                    }
                }
                Section("More Informations") {
                    TextField("Mail", text: $mail)
                        .keyboardType(.emailAddress)
                    TextField("Phone", text: $phone)
                    VStack {
                        Text("Diet")
                        Picker("", selection: $diet){
                            ForEach(diets, id: \.self) { value in
                                Text(String(value))
                            }
                        }
                        .pickerStyle(.segmented)
                        TextField("Other Diet", text: $diet)
                    }
                }
                Section("Age") {
                    DatePicker("Birth date:", selection: $birthDate, in: ...Date(), displayedComponents: .date).datePickerStyle(WheelDatePickerStyle()).font(.title)
                        .frame(height: 150)
                }.onChange(of: birthDate) {
                    age = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
                }
            } //Form
        } //VStack
        Button{
            do {
                let message = User(
                    id: idEvent,
                    firstname: firstname,
                    lastname: lastname,
                    phone: phone,
                    diet: diet,
                    mail: mail,
                    nationality: nationality,
                    birthdate: dateWithoutTime(date: birthDate),
                    fr:french,
                    en:english,
                    jp:japanese
                )
                newUserToEvent(message: message, completion: { success in
                    print(success)
                })
            }
        }label: {
            VStack(spacing: 6) {
                Image(systemName: "icloud.and.arrow.up.fill")
                Text("Create Event")
            }.frame(maxWidth: .infinity)
        }
        Button{
            do {
                let message = User(
                    id: idEvent,
                    firstname: firstname,
                    lastname: lastname,
                    phone: phone,
                    diet: diet,
                    mail: mail,
                    nationality: nationality,
                    birthdate: dateWithoutTime(date: birthDate),
                    fr:french,
                    en:english,
                    jp:japanese
                )
                print(message)
            }
        }label: {
            VStack(spacing: 6) {
                Image(systemName: "list.number")
                Text("Print")
            }.frame(maxWidth: .infinity)
        }
    } //body
} //struct

#Preview {
    AddRegisterView()
}


