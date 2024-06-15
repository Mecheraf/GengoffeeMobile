//
//  FooterComponent.swift
//  Gengoffee Test
//
//  Created by Alan Mecheraf on 24/05/2024.
//

import Foundation
import SwiftUI

struct FooterComponent:View {
    @State var event = false;
    @State var user = false;
    @State var hello = true;

    
    var body : some View {
        

        CustomHStack(widthWeights: [0.25, 0.25, 0.25, 0.25]){

            Button{
                event = true
                user = false
                hello = false
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "person.3")
                    Text("Event")
                }.frame(maxWidth: .infinity)
            }
            Button{
                event = false
                user = true
                hello = true
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "list.number")
                    Text("List")
                }.frame(maxWidth: .infinity)
            }
            
            Button{
                event = false
                user = true
                hello = true
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "list.number")
                    Text("Table")
                }.frame(maxWidth: .infinity)
            }
            Button{
                event = false
                user = true
                hello = true
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "option")
                    Text("Option")
                }.frame(maxWidth: .infinity)
            }

           // if event {
           //     GetEventsView()
           // }
        }
        .padding(.top, 10.0)
        .border(Color.black)
    }
    
    
}

#Preview {
    FooterComponent()
}
