//
//  CreateEventView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 20/06/2024.
//

import Foundation

import SwiftUI

struct CreateEventView: View {
    @State var token:String = "1"
    var firstname: String = ""
    @State private var place: String = ""
    @State private var type: String = "fr"
    @State private var location: String = "PARIS"
    @State private var date =  Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!



    let types = ["fr", "en", "jp", "karaoke"]
    let locations = ["PARIS", "TOKYO"]
    
    @State var message = Event(
        id: nil,
        type: "en",
        date: "2024-07-16 16:00:00",
        place: "",
        subscribe: 0,
        location: "PARIS",
        attendees: []
    )
    

    var body: some View {
            VStack{
                Form {
                    Section("Where the event is") {
                        Group {
                            Picker("City", selection: $location) {
                                ForEach(locations, id: \.self) {location in
                                    Text(location).tag(location)
                                }
                            }
                            .frame(height: 120)
                            TextField("Place", text: $place)
                        }
                    }
                    
                    Section("Language") {
                        Picker("Type of event", selection: $type) {
                            ForEach(types, id: \.self) { type in
                                switch type{
                                case "en":
                                    Text("English").tag(type)
                                case "jp":
                                    Text("Japanese").tag(type)
                                case "karaoke":
                                    Text("Karaoke").tag(type)
                                default:
                                    Text("French").tag(type)
                                }
                                
                                
                            }
                        }
                        .frame(height: 100)
                    }
                    
                    Section("Language of the Event") {
                        DatePicker(selection: $date, in: Date.now..., displayedComponents: [.date, .hourAndMinute])
                        {
                            Text("Select a date")
                        }.environment(\.timeZone, TimeZone(abbreviation: "CET")!)
                    }
                }
                .navigationTitle("Create Event")
                .pickerStyle(.wheel)
                Button{
                    do {
                        self.message.type = type
                        self.message.location = location
                        self.message.place = place
                        self.message.date = dateToCET(date:date)

                        addEvent(message: message, token:token, completion: { success in
                            print(success)
                        })
                    }
                }label: {
                    VStack(spacing: 6) {
                        Image(systemName: "icloud.and.arrow.up.fill")
                        if(self.place.isEmpty){
                            Text("Fill the form")
                                .foregroundColor(.gengoffeeRed)
                        } else {
                            Text("Create Event")
                        }
                    }.frame(maxWidth: .infinity)
                }
                .disabled(self.place.isEmpty)
            }
        }
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"")
        var body: some View {
            CreateEventView(token: session.token)
        }
    }
    return Preview()
}

