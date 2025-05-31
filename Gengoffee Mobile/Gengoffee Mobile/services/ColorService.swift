//
//  ColorService.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 12/07/2024.
//

import Foundation
import SwiftUI

func selectColor(nat:String) -> Color{
    switch nat {
    case "jp":
        return Color.gengoffeeRed
    case "en":
        return Color.gengoffeeGreen
    case "fr":
        return Color.gengoffeeBlue
    case "ハーフ", "half":
        return Color.gengoffeePink

    default :
        return .white
    }
}

func selectColorEvent(type:String) -> Color{
    switch type {
    case "jp", "karaoke":
        return Color.gengoffeeRed
    case "en", "fr":
        return Color.gengoffeeBlue
    default :
        return .white
    }
}
