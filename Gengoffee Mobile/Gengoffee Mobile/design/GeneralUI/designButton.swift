//
//  designButton.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 06/02/2025.
//

import Foundation
import SwiftUI

struct designButton:View {
    @State var icon:String
    @State var text:String

    var body : some View {
        VStack(spacing: 6) {
            if(icon.count > 0){
                Image(systemName: icon)
            }
            Text(text)
        }.frame(maxWidth: .infinity)
    }
}

func printDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        print(key)
    }
}
