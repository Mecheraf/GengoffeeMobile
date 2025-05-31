//
//  AttendeesService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI

func updateTableAttendee(attendees: [Attendee], token:String, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var golbalAPI = APIModel()
    
    var values:[Attendee] = []
    
    attendees.forEach{ element in
        if(element.tablenumber != 0 ){
            values.append(element)
        }
    }
    let message = [
        "attendees": values
    ]
        
    let url = URL(string: golbalAPI.API_Prod+"updateTableAttendee")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    
    let data = try! JSONEncoder().encode(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    
    var success:Bool! = false

    
    let task = URLSession.shared.dataTask(with: request)
    { data, response, error in
        if
            error == nil,
            let statusCode = (response as? HTTPURLResponse)?.statusCode
        {
            if statusCode == 200 {
                success = true
                print("SUCCESS")
            } else {
                success = false
                print("FAILURE")
            }
        }
        completion(success)
    }
    task.resume()
}

func createTables(attendees:[Attendee]) -> [TableModel] {
    var result:[TableModel] = []
    for index in 0...20 {
        result.append(TableModel(
            number:index,
            attendees: []
            )
        )
    }
    
    attendees.forEach{ attendee in
        result[attendee.tablenumber].attendees.append(attendee)
    }
    
    return result
}

func convertNewUser(user:User, idEvent:Int) -> newUser{
    return newUser(
        idEvent: idEvent,
        firstname: user.firstname,
        lastname: user.lastname,
        phone: user.phone,
        diet: user.diet,
        mail: user.mail,
        nationality: user.nationality,
        birthdate: dateWithoutTime(date: user.birthdate),
        fr:user.fr,
        en:user.en,
        jp:user.jp
    )
}

func updateUser(selectedUser:inout Int, id: Int) {
    if(selectedUser == id) {
        selectedUser = 0
    } else {
        selectedUser = id
    }
}

func FilterName(text:String) -> Int{
    if(text.count == 0){
        return -1
    } //If it's just a breakline
    
    if(text.lowercased().range(of: "japonais*", options: .regularExpression) != nil){
        return 0
    } else if ((text.lowercased().range(of: "français*", options: .regularExpression) != nil) ||
               (text.lowercased().range(of: "francais*", options: .regularExpression) != nil)){
        return 1
    } else if (text.lowercased().range(of: #"(?:^|\W)half(?:$|\W)"#, options: .regularExpression) != nil) ||
                (text.lowercased().range(of: "ハーフ*", options: .regularExpression) != nil) {
        return 2
    }
    
    return 3 //if it's a name
}

func SplitName(text:String, typeList:inout String, idEvent:Int, paid:Int) -> [Attendee] {
    var tmp:[Attendee] = []
    text.components(separatedBy: "\n").forEach{ word in
        switch FilterName(text:word) {
        case -1:
            break
        case 0:
            typeList = "jp"
        case 1:
            typeList = "fr"
        case 2:
            typeList = "ハーフ"
        default:
            tmp.append(
                Attendee(
                    idUser: -tmp.count - 1,
                    firstname: word,
                    lastname:"",
                    diet:Optional(""),
                    paid: paid,
                    idEvent: idEvent,
                    tablenumber: 0,
                    nationality: typeList,
                    changed:0
                )
            )
        }
    }
    return tmp
}

func concatNamePin(name:String) -> String{
    let array:[String] = name.components(separatedBy: " ")
    if(array.count > 1 && array[1].count > 0){
        return String(array[0] + "\n" + array[1].prefix(1))
    }
    return array[0]
}

func sortTypeAttendees(arr:[Attendee]) -> [Attendee]{
    return arr.sorted {$0.nationality < $1.nationality}
}

func sortNameAttendees(arr:[Attendee]) -> [Attendee]{
    return arr.sorted {$0.firstname < $1.firstname}
}

func fusionListAttendees(arr1:[Attendee], arr2:[Attendee]) -> [Attendee]{
    let tmp:[Attendee] = arr1 + arr2

    return sortTypeAttendees(arr:sortNameAttendees(arr:tmp))
}

func getLocalAttendees() -> [Attendee]{
    let defaults = UserDefaults.standard
    if let data = defaults.object(forKey: "attendees") as? Data {
        let decoder = JSONDecoder()
        if let savedData = try? decoder.decode([Attendee].self, from: data) {
            return savedData
        }
    }
    return []
}

func addTemporaryAttendee(message: temporaryAttendees, token:String, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var globalAPI = APIModel()
    
    let url = URL(string: globalAPI.API_Prod+"temporaryAttendee")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let data = try! JSONEncoder().encode(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

    var success:Bool! = false
    
    let task = URLSession.shared.dataTask(with: request)
    { data, response, error in
        if
            error == nil,
            let statusCode = (response as? HTTPURLResponse)?.statusCode
        {
            if statusCode == 200 {
                success = true
                print("SUCCESS")
            } else {
                success = false
                print("FAILURE")
            }
        }
        completion(success)
    }
    task.resume()
}

func getAttendees(token:String, finished: @escaping (_ success: [Attendee])->Void) {
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Prod+"getAttendees")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let data = try! JSONEncoder().encode("")
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

    var success:[Attendee]! = []

    let task = URLSession.shared.dataTask(with: request)
    { data, response, error in
        if
            error == nil,
            let statusCode = (response as? HTTPURLResponse)?.statusCode
        {
            if statusCode == 200 {
                let decoder = JSONDecoder()
                if let attendees:[Attendee] = try? decoder.decode([Attendee].self, from: data!) {
                    success = attendees
                }
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
        }
        finished(success)

    }
    task.resume()
}

func getTemporaryAttendees(finished: @escaping (_ success: [Attendee])->Void) {
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Prod+"getTemporaryAttendee")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let data = try! JSONEncoder().encode("")
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    var success:[Attendee]! = []

    let task = URLSession.shared.dataTask(with: request)
    { data, response, error in
        if
            error == nil,
            let statusCode = (response as? HTTPURLResponse)?.statusCode
        {
            if statusCode == 200 {
                let decoder = JSONDecoder()
                if let attendees:[Attendee] = try? decoder.decode([Attendee].self, from: data!) {
                    success = attendees
                }
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
        }
        finished(success)
    }
    task.resume()
}

