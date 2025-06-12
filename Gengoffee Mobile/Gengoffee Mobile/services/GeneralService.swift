//
//  GeneralService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 23/02/2025.
//

import Foundation
import SwiftUI

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

func resetDefaultsAttendee() {
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: "attendees")
}

func getFirstChar(text:String) -> String {
    return String(text.prefix(1))
}

func deleteDefaultsAttendee(id:Int) {
    let defaults = UserDefaults.standard
    if let data = defaults.object(forKey: "attendees") as? Data {
        let decoder = JSONDecoder()
        if var savedData:[Attendee] = try? decoder.decode([Attendee].self, from: data) {
            for(index, attendee) in savedData.enumerated(){
                if(id == attendee.idUser){
                    savedData.remove(at: index)
                }
            }
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(savedData) {
                UserDefaults.standard.set(encoded, forKey: "attendees")
            }
        }
    }
}

func loginFunc(username:String, password:String, finished: @escaping (_ success: String)->Void) {
    @StateObject var golbalAPI = APIModel()
    
    let url = URL(string: golbalAPI.API_Prod+"loginAdmin")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let message:Login = Login(
        username:username,
        password:password
    )
    let data = try! JSONEncoder().encode(message)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    
    var success:String! = ""

    let task = URLSession.shared.dataTask(with: request)
    { data, response, error in
        if
            error == nil,
            let statusCode = (response as? HTTPURLResponse)?.statusCode
        {
            if statusCode == 200 {
                let decoder = JSONDecoder()
                if let token:Token = try? decoder.decode(Token.self, from: data!) {
                    success = token.token
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
