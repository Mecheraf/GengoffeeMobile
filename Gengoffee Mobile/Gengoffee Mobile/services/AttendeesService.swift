//
//  AttendeesService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation

func filterAttendees (attendees: [Attendee]) -> [Attendee]{
    var result:[Attendee] = []
    attendees.forEach{attendee in
        if(attendee.paid != 0){
            result.append(attendee)
        }
    }
    return result
    
}
