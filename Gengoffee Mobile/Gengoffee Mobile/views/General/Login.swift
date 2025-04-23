//
//  Login.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 14/04/2025.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State var username:String = ""
    @State var password:String = ""
    @Binding var session:MainModel

    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            TextField("Username", text: $username)
                .onTapGesture {
                    hideKeyboard()
                }.underlineTextField()
            SecureField("Password", text: $password)
                .onTapGesture {
                    hideKeyboard()
                }.underlineTextField()
            HStack(spacing: 100){
                Button("Log in" , action: {
                    Task {
                        if(username.count > 0 && password.count > 0){
                            loginFunc(username: username, password: password, finished:
                                        { success in
                                session.token = success
                            })
                        }
                    }
                })
                Button("Offline mode" , action: {
                    do {
                        session = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"1")
                    }
                })
            }
        }
    }
}

struct LogoutView: View {
    @Binding var token:String
    @State private var showAlert = false

    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Button("Logout" , action: {
                Task {
                    showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you sure you want to unlog ?"),
                    primaryButton: .destructive(Text("Log out")) {
                        do {
                            token = ""
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [], attendees: [], selectedTab: .checkIn, token:"")
        var body: some View {
            Settings(session: $session)
        }
    }
    return Preview()
}
