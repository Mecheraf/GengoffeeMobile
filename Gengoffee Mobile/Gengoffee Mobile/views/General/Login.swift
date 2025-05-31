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
                LoginButton(session: $session, username: $username, password: $password)
                Button("Offline mode" , action: {
                    do {
                        session = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"1")
                    }
                })
            }
        }
    }
}

struct LoginButton: View {
    @Binding var session:MainModel
    @Binding var username:String
    @Binding var password:String
    @State var loading:Bool = false
    var body: some View {
        ZStack{
            Button("Log in" , action: {
                Task {
                    if(username.count > 0 && password.count > 0){
                        loginFunc(username: username, password: password, finished:
                                    { success in
                            session.token = success
                            loading = false
                        })
                    }
                }
            }).opacity(loading ? 0 : 1)
            SpinnerView().opacity(loading ? 1 : 0)
        }
    }
}

struct LogoutView: View {
    @Binding var token:String
    @State private var showAlert = false
    
    var body: some View {
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

#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [], attendees: [], selectedTab: .checkIn, token:"")
        var body: some View {
            LoginView(session: $session)
        }
    }
    return Preview()
}
