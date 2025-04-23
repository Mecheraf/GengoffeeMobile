//
//  UserModel.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 21/06/2024.
//

import Foundation

struct Language: Codable {
    let idUser:Int
    let name:String
    let level:String
}

struct User: Codable, Hashable, Identifiable {
    let id: Int?
    var firstname: String = ""
    var lastname: String = ""
    var phone: String = ""
    var diet: String = ""
    var mail: String = ""
    var nationality: String = "fr"
    var birthdate: Date = Date()
    var fr: Int = 0
    var en: Int = 0
    var jp: Int = 0
    
    init(){
        id = 0
        firstname = ""
        lastname = ""
        nationality = "fr"
        birthdate = Date()
        fr = 0
        en = 0
        jp = 0
        phone = ""
        mail = ""
        diet = "None"
    }
}

struct newUser: Codable {
    let idEvent: Int
    var firstname: String
    var lastname: String
    var phone: String
    var diet: String
    var mail: String
    var nationality: String
    var birthdate: String
    var fr: Int
    var en: Int
    var jp: Int
}

struct UsersToEvent : Codable {
    let idEvent : Int
    let users: [Int]
}
