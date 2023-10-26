//
//  ButtonWithLabel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct ButtonWithLabel: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(.white)
                .frame(height: 40)
                .padding(.horizontal)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppColors.Text.primary)
        )
        .padding()
    }
}
