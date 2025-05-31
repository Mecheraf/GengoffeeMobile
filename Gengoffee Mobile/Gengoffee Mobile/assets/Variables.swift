//
//  Variables.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 22/06/2024.
//

import Foundation
import SwiftUI

class APIModel: ObservableObject {
    @Published var API_Prod = "https://gengoffeeapi.azurewebsites.net/api/"
    @Published var API_Dev = "http://localhost:7071/api/"
}

class UIScreenSize: ObservableObject {
    @Published var width = UIScreen.main.bounds.width - 32.0
    @Published var height = UIScreen.main.bounds.height - 32.0
}

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

var eventsTest:[Event] = [
    Event(
        id: 128,
        type: "jp",
        date: "2024-07-07T16:00:00.000Z",
        place: "Les Berthom",
        subscribe: 1,
        location: "PARIS"
    ),
    Event(
        id: 129,
        type: "jp",
        date: "2024-07-07T16:00:00.000Z",
        place: "Bleu Montagne",
        subscribe: 1,
        location: "TOKYO",
        attendees: setAttendeesShort
    ),
    Event(
        id: 130,
        type: "en",
        date: "2024-07-07T16:00:00.000Z",
        place: "Food Hall Blast",
        subscribe: 1,
        location: "TOKYO",
        attendees: setAttendees
    )
]

var event = Event(
    id: 128,
    type: "jp",
    date: "2024-07-07T16:00:00.000Z",
    place: "Les Berthom",
    subscribe: 1,
    location: "PARIS"
)

var blankEvent = Event(
    id: 0,
    type: "fr",
    date: "",
    place: "Create temporary event",
    subscribe: 1,
    location: "",
    attendees: getLocalAttendees()
)

//Attendees
var alan = Attendee(
    idUser: 1,
    firstname: "Alan",
    lastname: "Mecheraf",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 1,
    nationality: "fr",
    changed:1
)

var mayu = Attendee(
    idUser: 2,
    firstname: "Mayu",
    lastname: "Koketsu",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 1,
    nationality: "jp",
    changed:1

)

var salim = Attendee(
    idUser: 3,
    firstname: "Salim",
    lastname: "Baroudi",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 1,
    nationality: "fr",
    changed:0
)

var vincent = Attendee(
    idUser: 4,
    firstname: "Vincent Truc",
    lastname: "Blablabla",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 2,
    nationality: "fr",
    changed:1
)

var daigo = Attendee(
    idUser: 5,
    firstname: "Daigo Lopes",
    lastname: "Lopes",
    diet: Optional(""),
    paid: 0,
    idEvent: 156,
    tablenumber: 2,
    nationality: "ハーフ",
    changed:0
)

var shiori = Attendee(
    idUser: 6,
    firstname: "Shiori",
    lastname: "Honjoya",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 2,
    nationality: "jp",
    changed:1
)

var adrien = Attendee(
    idUser: 7,
    firstname: "Adrien",
    lastname: "Valo",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 3,
    nationality: "fr",
    changed:1
)

var steve = Attendee(
    idUser: 8,
    firstname: "Steve",
    lastname: "Michiels",
    diet: Optional(""),
    paid: 0,
    idEvent: 156,
    tablenumber: 0,
    nationality: "",
    changed:0
)

var alan2 = Attendee(
    idUser: 11,
    firstname: "Alan",
    lastname: "Mecheraf",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 0,
    nationality: "fr",
    changed:0
)

var mayu2 = Attendee(
    idUser: 12,
    firstname: "Mayu",
    lastname: "Koketsu",
    diet: Optional(""),
    paid: 0,
    idEvent: 156,
    tablenumber: 0,
    nationality: "jp",
    changed:0

)

var salim2 = Attendee(
    idUser: 13,
    firstname: "Salim",
    lastname: "Baroudi",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 0,
    nationality: "fr",
    changed:0
)

var vincent2 = Attendee(
    idUser: 14,
    firstname: "Vincent",
    lastname: "Blablabla",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 0,
    nationality: "fr",
    changed:0
)

var daigo2 = Attendee(
    idUser: 15,
    firstname: "Daigo",
    lastname: "Lopes",
    diet: Optional(""),
    paid: 10,
    idEvent: 156,
    tablenumber: 0,
    nationality: "ハーフ",
    changed:0
)

var shiori2 = Attendee(
    idUser: 16,
    firstname: "Shiori",
    lastname: "Honjoya",
    diet: Optional(""),
    paid: 0,
    idEvent: 156,
    tablenumber: 0,
    nationality: "jp",
    changed:0
)

var adrien2 = Attendee(
    idUser: 17,
    firstname: "Adrien",
    lastname: "Valo",
    diet: Optional(""),
    paid: 0,
    idEvent: 156,
    tablenumber: 0,
    nationality: "fr",
    changed:0
)

var setAttendees:[Attendee] = [alan, mayu, salim, vincent, daigo, shiori, adrien, steve, alan2, mayu2, salim2, vincent2, daigo2, shiori2, adrien2]
var setAttendeesShort:[Attendee] = [alan, mayu, salim, vincent, daigo, shiori, adrien]

let tableGridLayout = (UIDevice.current.userInterfaceIdiom == .phone ?
                       Array(repeating: GridItem(.flexible(), spacing: 0), count: 2) : Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
)
let waitingGridLayout = (UIDevice.current.userInterfaceIdiom == .phone ?
                         Array(repeating: GridItem(.flexible(), spacing: 0), count: 4) : Array(repeating: GridItem(.flexible(), spacing: 0), count: 6))


