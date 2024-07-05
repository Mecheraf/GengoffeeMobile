//
//  RegisteredService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 21/06/2024.
//

import Foundation
import SwiftUI


func getAttendees() async throws -> [Attendee] {
    
    @StateObject var golbalAPI = APIModel()

    let url = URL(string: golbalAPI.API_Dev+"getAttendees")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Attendee].self, from: data)
    return wrapper
}

func getLanguages(id:[Int]) async throws -> [Attendee] {
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"getLanguages")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Attendee].self, from: data)
    return wrapper
}

func addUser(message: Event, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"insertuser")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let data = try! JSONEncoder().encode(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    
    var success:Bool!
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 200 {
            success = true
            print("SUCCESS")
        } else {
            success = false
            print("FAILURE")
        }
        completion(success)
    }
    task.resume()
}

func newUserToEvent(message: User, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"newUserToEvent")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let data = try! JSONEncoder().encode(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    
    var success:Bool!

    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 200 {
            success = true
            print("SUCCESS")
        } else {
            success = false
            print("FAILURE")
        }
        completion(success)
    }
    task.resume()
}

func updateAttendee(message: [String: [Attendee]], completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"updateAttendee")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    
    let data = try! JSONEncoder().encode(message)
    print(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    
    var success:Bool!

    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 200 {
            success = true
            print("SUCCESS")
        } else {
            success = false
            print("FAILURE")
        }
        completion(success)
    }
    task.resume()
}
