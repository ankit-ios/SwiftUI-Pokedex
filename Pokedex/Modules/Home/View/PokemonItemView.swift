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
    var gradientColors: [Color] {
        let types = pokemonDetail.types
        let name = types.map { (PokemonType(rawValue: $0.type?.name ?? "normal") ?? PokemonType.water).actionColorHex }
        return name.map { Color(hex: $0) }
    }
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: (pokemonDetail.sprites.thumbnail?.isEmpty ?? true) ? "" : pokemonDetail.sprites.thumbnail!)) { image in
                VStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(pokemon.name)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
            } placeholder: {
                ProgressView()
            }
            .addGradient(colors: gradientColors)
        }
    }
}

struct PokemonItemView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: .init(name: "kakuna", url: "https://pokeapi.co/api/v2/pokemon/14/"), pokemonDetail: .dummy)
    }
}
