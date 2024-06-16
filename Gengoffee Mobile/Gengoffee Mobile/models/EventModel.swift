//
//  EventModel.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation

struct Wrapper: Codable {
    let events: [Event]
}

struct Event: Codable {
    let id: Int
    let type: String
    let date: String
    let place: String
    let subscribe: Int
    let location: String
}
