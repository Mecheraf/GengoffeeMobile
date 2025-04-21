//
//  NewAttendeeRow.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 13/07/2024.
//

import Foundation
import SwiftUI


struct NewAttendeeRow: View {
    var user: User

    var body: some View {
        HStack {
            Text(user.firstname)
            Text(user.lastname)
        }
        .foregroundColor(selectColor(nat: user.nationality))
    }
}
