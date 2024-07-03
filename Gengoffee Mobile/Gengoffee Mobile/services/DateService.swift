//
//  DateService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 20/06/2024.
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

func dateToCET(date:Date) -> String {
    let f = DateFormatter()
    f.timeZone = TimeZone(identifier: "CET")!
    f.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return f.string(from:date)
}

func dateWithoutTime(date:Date) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}
