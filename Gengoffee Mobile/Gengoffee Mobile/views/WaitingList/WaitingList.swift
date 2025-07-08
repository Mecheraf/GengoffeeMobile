//
//  WaitingList.swift
//  } Mobile
//
//  Created by Alan Mecheraf on 31/01/2025.
//

import Foundation
import SwiftUI

struct WaitingList:View {
    @Binding var session: MainModel
    @State var isSelected:Bool = false
    @Binding var selectedUser:Int
    @StateObject var containerSize = UIScreenSize()
    @State var idEvent:Int = 0


    
    var body: some View {
        HStack{
            VStack{
                AttendeesAlignement(session:$session, selectedUser: $selectedUser, idEvent:idEvent)
                    .padding([.top, .bottom], 7)
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
        .frame(height: isSelected ? 180: 30)
        
    }
}



#Preview {
    struct Preview: View {
        @State var session: MainModel = MainModel(events: [], attendees: setAttendees, selectedTab: .tables, token:"")
        var body: some View {
            TablePlanView(session: $session)
        }
    }
    return Preview()
}
