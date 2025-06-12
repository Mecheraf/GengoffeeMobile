//
//  Settings.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 25/02/2025.
//

import SwiftUI

struct Settings:View {
    @State private var showAlert = false
    @Binding var session:MainModel
    
    var body: some View {
        List {
            Section() {
                Button{// Clean App Storage
                    do {
                        showAlert = true
                    }
                } label: {Text("Reset Attendees")}
            }
            LogoutView(token: $session.token)
        }
        .navigationTitle("Settings")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure you want to delete this?"),
               message: Text("There is no undo"),
               primaryButton: .destructive(Text("Delete")) {
                   do {
                    addTemporaryAttendee(message: temporaryAttendees(
                    type:0,
                    attendees:[]
                    ), token: session.token, completion: { success in
                       print(success)
                    })
                   }
                   
                   resetDefaultsAttendee()

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
            Settings(session: $session)
        }
    }
    return Preview()
}
