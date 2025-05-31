//
//  Attendee.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 25/03/2025.
//

import Foundation

struct Attendee: Codable {
    let idUser:Int
    var firstname: String
    var lastname: String
    var diet: String?
    var paid:Int
    var idEvent: Int
    var tablenumber:Int
    var nationality:String
    var changed:Int
    
    init(idUser:Int, firstname:String, lastname:String, diet:String?, paid:Int, idEvent:Int, tablenumber:Int, nationality:String, changed:Int){
        self.idUser = idUser
        self.firstname = firstname
        self.lastname = lastname
        self.diet = diet
        self.paid = paid
        self.idEvent = idEvent
        self.tablenumber = tablenumber
        self.nationality = nationality
        self.changed = changed
    }
}

struct updatedAttendee: Codable {
    let idUser:Int
    let paid:Int
    let idEvent: Int
}

struct temporaryAttendees: Codable {
    let type:Int
    let attendees:[Attendee]
}
