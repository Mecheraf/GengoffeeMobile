//
//  NewAttendeeList.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 13/07/2024.
//

import Foundation
import SwiftUI


struct NewAttendeeList: View {
    @State var idEvent:Int
    @State private var users:[User] = []
    @State private var newUsers = Set<User>()
    @State var attendees:[Attendee] = []
        
    var body: some View {
        NavigationView {
            VStack{
                List(users, id:\.self, selection: $newUsers){ user in
                        NewAttendeeRow(user: user)
                }
                
                Button{
                    do {
                        let message = getUsersId(users: newUsers)
                        addUsersToEvent(message: message, idEvent: idEvent, completion: { success in
                            print(success)
                        })                    }
                }label: {
                    VStack(spacing: 6) {
                        Image(systemName: "cloud")
                        Text("Update")
                    }.frame(maxWidth: .infinity)
                }
                
                Button{
                    do {
                        print(newUsers)
                    }
                }label: {
                    VStack(spacing: 6) {
                        Image(systemName: "cloud")
                        Text("Print")
                    }.frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Users")
            .toolbar{
                EditButton()
            }
            .task {
                do {
                    //users = try await getUsers()
                    print("hi")
                    users = filterUsers(users: try await getUsers(), attendees:getAttendeesId(attendees: try await getAttendees()), idEvent: idEvent)
                } catch {
                    users = []
                }
            }
        }
    }
}

#Preview {
    NewAttendeeList(idEvent: 139)
}
