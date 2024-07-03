//
//  RegisteredRow.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 26/06/2024.
//

import Foundation
import SwiftUI

struct RegisteredRow: View {
    var attendee: Attendee!
    @State var paid:Int
    let prices:[Int] = [0, 10, 11]

    var body: some View {
        HStack {
            Text(attendee.firstname)
            Text(attendee.lastname)
            Spacer()
            Picker("", selection: $paid){
                ForEach(prices, id: \.self) { value in
                    Text(String(value))
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
        }
    }
}
