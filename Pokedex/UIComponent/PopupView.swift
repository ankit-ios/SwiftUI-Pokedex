//
//  PopupView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct PopupView<Content>: View where Content: View {
    @Binding var isShowingPopup: Bool
    let content: () -> Content

    var body: some View {
        ZStack {
            Color.clear // Transparent background
                .opacity(0.1) // 10% opacity
            ScrollView {
                content()
            }
            .cornerRadius(10)
            .padding(20)
        }
        .background(AppColors.Text.primary)
        .onTapGesture {
            isShowingPopup.toggle()
        }
    }
}
