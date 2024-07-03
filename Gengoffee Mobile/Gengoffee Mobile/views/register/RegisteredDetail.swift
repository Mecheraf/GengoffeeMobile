//
//  RegisteredDetail.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredDetail: View {
    var attendee: Attendee!
    
    var body: some View {
        VStack(){
            Text(attendee.firstname)
            Text(attendee.lastname)
            Text(attendee.diet ?? "")
        }
    }
}
