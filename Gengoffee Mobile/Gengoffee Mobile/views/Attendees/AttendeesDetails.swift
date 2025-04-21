//
//  AttendeesDetails.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 04/07/2024.
//

import Foundation
import SwiftUI

struct AttendeesDetails: View {
    var attendee: Attendee!
    
    var body: some View {
        VStack(){
            Text(attendee.firstname)
            Text(attendee.lastname)
            Text(attendee.diet ?? "")
        }
    }
}

//#Preview {
//    EventView(selectedTab: .constant(.tables))
//}
