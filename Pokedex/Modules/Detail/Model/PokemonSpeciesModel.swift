//
//  PokemonSpeciesModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

struct PokemonSpeciesModel {
    
    private let pokemonSpecies: PokemonSpecies
    
    init(pokemonSpecies: PokemonSpecies) {
        self.pokemonSpecies = pokemonSpecies
    }
    
    func getFlavorText() -> String {
        pokemonSpecies.flavorTextEntries?.filter { $0.language?.name == "en" }.first?.flavorText ?? ""
    }
    
    func getEggGroups() -> [String] {
        pokemonSpecies.eggGroup?.compactMap { $0.name } ?? []
    }
}
