//
//  WaitingList.swift
//  } Mobile
//
//  Created by Alan Mecheraf on 31/01/2025.
//

import Foundation
import SwiftUI

struct WaitingList:View {
    @Binding var attendees: [Attendee]
    @State var isSelected:Bool = false
    @Binding var selectedUser:Int
    @StateObject var containerSize = UIScreenSize()

    
    var body: some View {
        HStack{
            VStack{
                AttendeesAlignement(attendees:$attendees, selectedUser: $selectedUser)
                    .onTapGesture {
                        if(selectedUser != 0){
                            attendees[findIdUser(attendees: attendees, idUser: selectedUser)].tablenumber = 0
                            selectedUser = 0
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(attendees) {
                                UserDefaults.standard.set(encoded, forKey: "attendees")

                            }
                        }
                    }
                    .padding([.top, .bottom], 8)
            }
            .background{
                Color.white
                    .overlay(
                        Rectangle()
                            .fill(Color(red: 233 / 255, green: 233 / 255, blue: 233 / 255))
                    )
            }
            .cornerRadius(3)
            .frame(width: containerSize.width)
            VStack{
                minimizeButton(isSelected: $isSelected)
                    .padding([.top], 5)
                if(isSelected){
                    Spacer()
                }
            }
            
            

        }
        .frame(height: isSelected ? 180: 25)
        
    }
}


#Preview {
    struct Preview: View {
        @State var attendees = setAttendees
        @State var selectedUser:Int = 0

        var body: some View {
            WaitingList(attendees: $attendees, isSelected: false, selectedUser: $selectedUser)
        }
    }
    return Preview()
}
