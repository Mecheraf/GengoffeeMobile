//
//  newTable.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/02/2025.
//

import Foundation
import SwiftUI

struct newTableButton:View {
    @Binding var tables:[TableModel]
    var body : some View {
            Button("New table"){
                do {
                    if(tables.count > 0) {
                        tables.append(createTable(numberTable: tables[tables.count-1].number+1))
                    } else {
                        tables.append(createTable(numberTable:1))
                    }
                }
            }
    }
}

struct updateAttendeesButton:View {
    @Binding  var attendees: [Attendee]
    @State var token:String
    @State var idEvent:Int

    var body : some View {
            Button("Update", action: {
                Task { //Need to update the attendees table before 
                    getAttendees(token: token, finished: { success in
                        Task {
                            attendees = fusionListAttendees(arr1: try await getTemporaryAttendees(), arr2: success)
                        }
                    })
                }
            })
    }
}
