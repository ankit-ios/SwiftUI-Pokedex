//
//  PokemonItemView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonItemView: View {
    let pokemon: PokemonItem
    let pokemonDetail: PokemonDetail
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: (pokemonDetail.sprites.thumbnail?.isEmpty ?? true) ? "" : pokemonDetail.sprites.thumbnail!)) { image in
                VStack {
                    image
                        .resizable()
                        .aspectRatio(1.1, contentMode: .fit)
                    
                    Text(pokemon.name.capitalized)
                        .font(AppFont.body)
                        .foregroundColor(AppColors.Text.primary)
                    Text(String(format: "00%d", pokemonDetail.id))
                        .font(AppFont.caption)
                        .foregroundColor(AppColors.Text.primary)
                    Spacer()
                }
            } placeholder: {
                ProgressView()
            }
            .addGradient(colors: pokemonDetail.gradientColors)
        }
    }
}

struct PokemonItemView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: .init(name: "kakuna", url: "https://pokeapi.co/api/v2/pokemon/14/"), pokemonDetail: .dummy)
    }
}
