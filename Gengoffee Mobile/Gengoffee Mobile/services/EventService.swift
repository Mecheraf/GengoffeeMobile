//
//  EventService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/06/2024.
//

import Foundation

func dateToSQLDate(_ string: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let date = dateFormatter.date(from: string) else { return "" }
    dateFormatter.dateFormat = "MM/dd/yy, hh:mma"
    return dateFormatter.string(from: date)
}

func getEvents() async throws -> [Event] {
    
    let url = URL(string: "http://localhost:7071/api/getNextEvents?limit=5")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Event].self, from: data)
    return wrapper
}
