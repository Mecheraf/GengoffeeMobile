//
//  Variables.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 22/06/2024.
//

import Foundation
import SwiftUI

class APIModel: ObservableObject {
    @Published var API_Prod = ""
    @Published var API_Dev = "http://localhost:7071/api/"
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
