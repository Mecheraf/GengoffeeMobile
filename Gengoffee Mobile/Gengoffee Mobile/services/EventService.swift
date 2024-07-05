//
//  EventService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation
import SwiftUI


func getEventsOld(limit:Int) async throws -> [Event] {
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"getNextEvents")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Event].self, from: data)
    return wrapper
}

func getEvents(limit:Int) async throws -> [Event] {
    
    @StateObject var golbalAPI = APIModel()
    
    var components = URLComponents(string: golbalAPI.API_Dev+"getNextEvents")!

    components.queryItems = [
        URLQueryItem(name: "limit", value: String(limit))
    ]
    guard let url = components.url else {
        throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Event].self, from: data)
    return wrapper
}



func addEvent(message: Event, completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"insertevent")!
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

func getAttendeesPerEvent(idEvent:Int, attendees: [Attendee]) -> [Attendee] {
    var result: [Attendee] = []
    attendees.forEach{ attendee in
        if(attendee.idEvent == idEvent){
            result.append(attendee)
        }
    }
    return result
}

func assignAttendeesToEvents(limit: Int, attendees: [Attendee]) async -> [Event]{
    
    var events:[Event] = []
    do {
        events = try await getEvents(limit: limit)
        events.enumerated().forEach{ index, event in
            events[index].attendees = getAttendeesPerEvent(idEvent: events[index].id!, attendees: attendees)
        }
    } catch {
        print(error)
    }
    return events
}


