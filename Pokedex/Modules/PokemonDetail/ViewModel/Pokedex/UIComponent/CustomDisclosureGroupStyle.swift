//
//  CustomDisclosureGroupStyle.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI

struct CustomDisclosureGroupStyle<Image: View>: DisclosureGroupStyle {
    let image: Image
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            image
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                configuration.isExpanded.toggle()
            }
        }
        if configuration.isExpanded {
            configuration.content
                .padding(.leading, 30)
                .disclosureGroupStyle(self)
        }
    }
}
