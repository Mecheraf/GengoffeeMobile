//
//  MainModel.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 12/04/2025.
//

import Foundation

struct MainModel: Codable {
    var events: [Event]
    var attendees: [Attendee]
    var selectedTab:FooterSelection
    var token:String
    
    init(events:[Event], attendees:[Attendee], selectedTab:FooterSelection, token:String){
        self.events = events
        self.attendees = attendees
        self.selectedTab = selectedTab
        self.token = token
    }
}

struct Login: Codable {
    var username: String
    var password: String
    
    init(username:String, password:String){
        self.username = username
        self.password = password
    }
}

struct Token: Codable {
    var token:String
}
