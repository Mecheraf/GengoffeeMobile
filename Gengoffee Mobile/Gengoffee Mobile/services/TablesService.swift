//
//  Tables.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/02/2025.
//

import Foundation
import SwiftUI

func createTable(numberTable:Int) -> TableModel{
    //Create a new table and return it
    return TableModel(
        number: numberTable,
        attendees: []
    )
}

func findIdUser(attendees:[Attendee], idUser:Int) -> Int{
    //find the position of an idUser in an array of Attendee
    for(index, attendee) in attendees.enumerated(){
        if(attendee.idUser == idUser){
            return index
        }
    }
    return 0
}

func checkTableUser(attendees:[Attendee], number:Int) -> Bool{
    var res = true
    for attendee in attendees {
        if(attendee.tablenumber == number){
            res = false
            break
        }
    }
    return res
}

func checkTables(attendees:[Attendee]) -> [TableModel]{
    var count = 0
    var res:[TableModel] = []
    for attendee in attendees {
        if(attendee.tablenumber > count){
            count = attendee.tablenumber
        }
    }
    
    if(count > 0){
        for i in 1...count  {
            res.append(createTable(numberTable:i))
        }
    }
    return res
}

func countTableUsers(attendees:[Attendee], type:[String], tableNumber:Int) -> Int {
    var res = 0
    attendees.forEach{ element in
        if(element.tablenumber == tableNumber && type.contains(element.nationality)){
            res+=1
        }
    }
    return res
}
