//
//  RegisteredView.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 21/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredView: View {
    var attendees: [Attendee]?
    //@State var languages: [Language]?


    var body: some View {
        VStack(alignment: .leading){
            if let attendees {
                ForEach(Array(attendees.enumerated()), id: \.offset){ index, attendee in
                    let foregroundColor = attendee.diet != nil ? Color.red : Color.black
                    Text(attendee.firstname+" "+attendee.lastname).foregroundStyle(foregroundColor)
                }
            }
        }
    }
}
