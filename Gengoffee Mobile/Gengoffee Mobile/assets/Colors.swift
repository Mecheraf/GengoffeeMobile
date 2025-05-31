//
//  Colors.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 31/01/2025.
//

import SwiftUI


extension Color {

    public static var gengoffeeRed: Color {
        return Color(UIColor(red: 193/255, green: 33/255, blue: 46/255, alpha: 1.0))
    }
    public static var gengoffeeBlue: Color {
        return Color(UIColor(red: 0/255, green: 61/255, blue: 137/255, alpha: 1.0))
    }
    public static var gengoffeePink: Color {
        return Color(UIColor(red: 230/255, green: 194/255, blue: 208/255, alpha: 1.0))
    }
    public static var gengoffeeGreen: Color {
        return Color(UIColor(red: 0/255, green: 128/255, blue: 95/255, alpha: 1.0))
    }
    
    public static var Text: Color {
        @Environment(\.colorScheme) var colorScheme
        return (colorScheme == .dark ? Color(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)) : Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)) )
    }
    
}
