//
//  PokemanEvolutionChainViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import Foundation

class PokemanEvolutionChainViewModel: ObservableObject {
    
    let pokemonDetail: PokemonDetail
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    func getPreviousPokemanId() -> Int? {
        (pokemonDetail.id > 1) ? (pokemonDetail.id - 1) : nil
    }
    
    func getNextPokemanId() -> Int {
        (pokemonDetail.id + 1)
    }
}
