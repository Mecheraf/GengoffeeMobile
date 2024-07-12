//
//  AttendeesService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI

func filterAttendees (attendees: [Attendee]) -> [Attendee]{
    var result:[Attendee] = []
    attendees.forEach{attendee in
        if(attendee.paid != 0){
            result.append(attendee)
        }
    }
    return result
}

func updateTableAttendee(message: [String: [Attendee]], completion: @escaping (_ success: Bool) -> Void){
    
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Dev+"updateTableAttendee")!
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

func createTables(attendees:[Attendee]) -> [TableModel] {
    var result:[TableModel] = []
    for index in 1...20 {
        result.append(TableModel(
            number:index,
            attendees: []
            )
        )
    }
    
    attendees.forEach{ attendee in
        result[attendee.tablenumber - 1].attendees.append(attendee)
    }
    
    return result
}
