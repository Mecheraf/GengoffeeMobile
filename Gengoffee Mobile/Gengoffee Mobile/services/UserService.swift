//
//  UserService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 13/07/2024.
//

import Foundation
import SwiftUI

func getUsers() async throws -> [User] { 
    
    @State var golbalAPI = APIModel()
    let url = URL(string: golbalAPI.API_Prod+"getUsers")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([User].self, from: data)
    return wrapper
}

func getLanguages(id:[Int]) async throws -> [Attendee] {
    
    @State var globalAPI = APIModel()
    
    let url = URL(string: globalAPI.API_Prod+"getLanguages")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Attendee].self, from: data)
    return wrapper
}

func updateUser(message: [Attendee], completion: @escaping (_ success: Bool) -> Void){
    
    @State var globalAPI = APIModel()
    
    let url = URL(string: globalAPI.API_Prod+"updateUser")!
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
