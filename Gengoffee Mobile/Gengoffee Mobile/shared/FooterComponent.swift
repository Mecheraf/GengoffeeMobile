//
//  FooterComponent.swift
//  Gengoffee Test
//
//  Created by Alan Mecheraf on 24/05/2024.
//

import Foundation
import SwiftUI

enum FooterSelection:Int {
    case checkIn = 1
    case tables = 2
    case plus = 3
    case createEvent = 4

    
}

struct FooterComponent:View {
    @State var event = false;
    @State var user = false;
    @State var hello = true;
    
    @Binding var selectedTab:FooterSelection


    
    var body : some View {
        
        HStack(spacing:10){
            Button {
                selectedTab = .checkIn
            } label: {
                ZStack {
                    FooterButtonView(image: "checklist", text: "Check In", isActive: selectedTab == .checkIn)
                }
            }
            Button {
                selectedTab = .checkIn
            } label: {
                ZStack {
                    FooterButtonView(image: "checklist", text: "Check In", isActive: selectedTab == .checkIn)
                }
            }
            Button {
                selectedTab = .plus
            }label: {
               VStack{
                   ZStack{
                       VStack(spacing: 3){
                           RoundedRectangle(cornerRadius: 30)
                               .frame(width: 60,height: 60)
                               .foregroundColor(.blue)
                       }
                       VStack(spacing: 3){
                           Image(systemName: "person.badge.plus").font(.title).foregroundColor(.white)
                       }
                   }
                   Spacer()
               }
            }
            Button {
                selectedTab = .tables

            } label: {
                FooterButtonView(image: "table.furniture", text: "Tables", isActive: selectedTab == .tables)
            }
            Button {
                selectedTab = .createEvent

            } label: {
                FooterButtonView(image: "plus.app", text: "New Event", isActive: selectedTab == .createEvent)
            }

        }
        .frame(height: 40)
        
    }
    
    
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        FooterComponent(selectedTab: .constant(.plus))
    }
}

struct FooterButtonView: View {
    
    var image:String
    var text:String
    var isActive:Bool
    
    var body: some View {
        HStack(spacing: 10){
            GeometryReader{
                geo in
                VStack(spacing: UIDevice.isIPad ? 6 : 3){
                    Rectangle()
                        .frame(height: 0)
                    Image(systemName:image)
                        .resizable()
                        .frame(width: UIDevice.isIPad ? 30 : 24,height: UIDevice.isIPad ? 30 : 24)
                        .foregroundColor(isActive ? .blue : .gray)
                    Text(text)
                        .font(.caption)
                        .foregroundColor(isActive ? .blue : .gray)
                }
            }
        }
    }
}
