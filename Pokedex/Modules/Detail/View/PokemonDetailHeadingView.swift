//
//  PokemonDetailHeadingView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonDetailHeadingView: View {
    
    let pokemonDetail: PokemonDetail
    @Binding var pokemonSpices: PokemonSpeciesModel?
    @State private var isExpanded = false
    
    
    var body: some View {
        GeometryReader { geometry in
            HStack (alignment: .center, spacing: 20) {
                
                ImageViewWithGradient(imageURL: pokemonDetail.sprites.actualImage ?? "", gradientColors: pokemonDetail.gradientColors)
                    .frame(width: geometry.size.width*0.4, height: geometry.size.height)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(pokemonSpices?.getFlavorText() ?? "")
                        .multilineTextAlignment(.leading)
                        .lineLimit(isExpanded ? nil : 2)
                    
                    //read more/less button
                    Button(action: { withAnimation { isExpanded.toggle() }})
                    {
                        Text(isExpanded ? "Read Less" : DetailScreenLabels.readMoreButton)
                            .foregroundColor(.blue)
                            .underline()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PokemonDetailHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailHeadingView(pokemonDetail: .dummy, pokemonSpices: .constant(nil))
    }
}

