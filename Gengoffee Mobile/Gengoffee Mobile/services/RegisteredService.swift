//
//  RegisteredService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 21/06/2024.
//

import Foundation
import SwiftUI

func convertUpdatedAttendee(attendees:[Attendee]) -> [updatedAttendee]{
    var tmp:[updatedAttendee]=[]
    attendees.forEach{attendee in
        tmp.append(updatedAttendee(idUser:attendee.idUser,
                                   paid:attendee.paid,
                                   idEvent:attendee.idEvent)
        )
    }
    return tmp
}

func addUpdatedAttendee(newAttendee:Attendee, list:inout [Attendee]){
    for(index, attendee) in list.enumerated() {
        if attendee.idUser == newAttendee.idUser{
            list[index] = newAttendee
            return;
        }
    }
    list.append(newAttendee)
}

func addUser(message: Event, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var globalAPI = APIModel()
    
    let url = URL(string: globalAPI.API_Dev+"insertuser")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
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

func newUserToEvent(message: newUser, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var globalAPI = APIModel()
    
    let url = URL(string: globalAPI.API_Dev+"newUserToEvent")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
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

func updateAttendee(message: [Attendee], token:String, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var globalAPI = APIModel()
    let tmp = [
        "attendees":convertUpdatedAttendee(attendees: message)
    ]
    
    let url = URL(string: globalAPI.API_Dev+"updateAttendee")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    
    let data = try! JSONEncoder().encode(tmp)
    print(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    request.setValue(
        "Bearer \(token)",
        forHTTPHeaderField: "Authorization"
    )
    
    var success:Bool! = false

    //print(data)
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
