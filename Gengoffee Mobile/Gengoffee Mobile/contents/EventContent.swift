//
//  EventContent.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation
import SwiftUI

struct EventContent: View {
    @State var events: [Event]?


    var body: some View {
        VStack(alignment: .leading){
            if let events {
                ForEach(events, id: \.id) { event in
                    Text(event.place)
                    Text(dateToSQLDate(event.date)+"\n")
                }
            }
        }.task {
            do {
                events = try await getEvents()
                
            } catch {
                events = nil
            }
        }
    }
    
}

#Preview {
    EventContent()
}
