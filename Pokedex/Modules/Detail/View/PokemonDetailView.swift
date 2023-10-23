//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonDetailView: View {
   
    let pokemonItem: PokemonItem
    let pokemonDetail: PokemonDetail
    @Binding var isPokemonDetailPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    //Heading view
                    PokemonDetailHeadingView(pokemonDetail: pokemonDetail)
                        .frame(height: 300)
                        .padding(.bottom)
                    Spacer()
                    
                    //Pokeman Ability view
                    PokemanAbilityView(pokemonDetail: pokemonDetail)
                        .frame(height: 320)
                        .padding(.bottom)
                    Spacer()
                    
                    //Pokeman Ability view
                    PokemanStateView(pokemonDetail: pokemonDetail)
                        .frame(height: 320)
                        .padding(.bottom)
                    
                    
                    PokemanEvolutionChainView(pokemonDetail: pokemonDetail)
                        .frame(height: 320)
                        .padding(.bottom)
                    
                } //Outer VStack
                .padding()
            }
            .background(Color(hex: "#DEEDED"))
        }
        .navigationTitle(pokemonItem.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonItem: .init(name: "ankit", url: ""), pokemonDetail: PokemonDetail.dummy, isPokemonDetailPresented: .constant(false))
    }
}
