//
//  eventDetails.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 24/01/2025.
//

import SwiftUI
import Foundation
import AudioToolbox

enum ActiveAlert {
    case first, second
}


struct EventDisplay: View {
    @State var event: Event
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first
    let defaults = UserDefaults.standard
    @State var timeRemaining = 7680
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var textColor = Color(Color.gengoffeeBlue)

    
    var body: some View {
        VStack(){
            Button{
                do {
                    if(activeAlert == .first) {
                        showAlert = true
                    }
                }
            } label: { designButton(icon:"", text: event.place + " " + event.location + " " + dateToSQLDate(event.date))
            }
            if(activeAlert == .second){
                Text("\((timeRemaining/60)%16):\(String(format: "%02d",(timeRemaining%60)%60))")
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                        if ((timeRemaining/60)%16) == 0 {
                            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            showAlert = true
                        }
                    }
            }
        }
        .foregroundStyle(textColor)
        .alert(isPresented: $showAlert) {
            switch activeAlert{
            case .first:
                Alert(
                    title: Text("Start the event ?"),
                    primaryButton: .destructive(Text("Start")) {
                        do {
                            activeAlert = .second
                        }
                    },
                    secondaryButton: .cancel()
                )
            default:
                Alert(
                    title: Text("Change the language"),
                    dismissButton: Alert.Button.default(
                        Text("OK"), action: {
                            switch textColor {
                            case Color(Color.gengoffeeBlue):
                                textColor = Color(Color.gengoffeeRed)
                            default:
                                textColor = Color(Color.gengoffeeBlue)
                            }
                        }
                    )
                )
            }
        }
    }
}


#Preview {
    struct Preview: View {
        @State var selectedTab:FooterSelection = .tables
        @State var token:String = ""
        @State var session: MainModel = MainModel(events: [blankEvent], attendees: getLocalAttendees(), selectedTab: .checkIn, token:"")
        var body: some View {
            EventDetail(event:event, session: $session)

        }
    }
    return Preview()
}


