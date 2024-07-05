//
//  UserModel.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 21/06/2024.
//

import Foundation

struct WrapperAttendee: Codable {
    let attendees: [Attendee]
}

struct Language: Codable {
    let idUser:Int
    let name:String
    let level:String
}

struct Attendee: Codable {
    let idUser:Int
    let firstname: String
    let lastname: String
    let diet: String?
    var paid:Int
    let idEvent: Int
}

struct User: Codable {
    let id: Int?
    let firstname: String
    let lastname: String
    let phone: String
    let diet: String
    let mail: String
    let nationality: String
    let birthdate: String
    let fr: Int
    let en: Int
    let jp: Int
}
