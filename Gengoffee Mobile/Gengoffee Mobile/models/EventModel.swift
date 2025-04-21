//
//  EventModel.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation
import SwiftUI


struct Event: Codable {
    let id: Int?
    var type: String
    var date: String
    var place: String
    var subscribe: Int
    var location: String
    var attendees: [Attendee]?
    
    mutating func assignAttendeesToEvent(attendees:[Attendee]) {
        self.attendees = getAttendeesPerEvent(idEvent: self.id ?? 0, attendees: attendees)
    }
    

}


