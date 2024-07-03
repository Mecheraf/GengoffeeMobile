//
//  CreateEventView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 20/06/2024.
//

import Foundation

import SwiftUI

struct CreateEventView: View {
    @State var event: Event?
    @State var events: [Event]?
    var firstname: String = ""
    @State private var place: String = ""
    @State private var type: String = "fr"
    @State private var location: String = "PARIS"
    @State private var date =  Date()
    var f = Date.FormatStyle.dateTime



    let types = ["fr", "en", "jp"]
    let locations = ["PARIS", "TOKYO"]
    
    @State var message = Event(
        id: nil,
        type: "en",
        date: "2024-07-16 16:00:00",
        place: "",
        subscribe: 0,
        location: "PARIS"
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
                                Text(type).tag(type)
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


                        addEvent(message: message, completion: { success in
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
                        self.message.type = type
                        self.message.location = location
                        self.message.place = place
                        print(dateToCET(date:date))
                        print(self.message)
                    }
                }label: {
                    VStack(spacing: 6) {
                        Image(systemName: "list.number")
                        Text("Print")
                    }.frame(maxWidth: .infinity)
                }
            }
        }
    
}

#Preview {
    CreateEventView()
}

