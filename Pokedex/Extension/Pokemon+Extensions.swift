//
//  Pokemon+Extensions.swift
//  Pokedex
//
//  Created by Ankit Sharma on 22/10/23.
//

import SwiftUI


extension View {
    func addGradient(colors: [Color]) -> some View {
        let gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
        return self.background(gradient)
    }
    
    func removeGradient() -> some View {
        return self
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        // Skip the '#' character
        scanner.currentIndex = hex.index(after: hex.startIndex)
        
        // Read the hex value
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

extension UIApplication {
    
    ///dismiss the keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
