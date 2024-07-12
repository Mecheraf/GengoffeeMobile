//
//  TableRow.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/07/2024.
//

import Foundation
import Foundation
import SwiftUI

struct TableRow: View {
    let tableNumber:Int
    let numberOfAttendees:Int
    
    var body: some View {
        HStack {
            Text("Table : "+String(tableNumber))
            Spacer()
            Text(String(numberOfAttendees))
        }
    }
}
