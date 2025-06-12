//
//  Extensions.swift
//  Gengoffee Mobile
//
//  Created by Alan Mecheraf on 16/03/2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .frame(width:200)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(Color.gengoffeeBlue)
            .padding(10)
    }
}
