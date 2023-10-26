//
//  PokemonEvolutionChainModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct PokemonEvolutionChainModel {
    private let pokemonEvolutionChain: PokemonEvolutionChain
    
    init(pokemonEvolutionChain: PokemonEvolutionChain) {
        self.pokemonEvolutionChain = pokemonEvolutionChain
    }
    
    func getAllSpecies() -> [PokemonNameURL] {
        guard
            let chain = self.pokemonEvolutionChain.chain
        else { return [] }
        return getSpecies(from: chain)
    }
    
    ///private recursive func to get all secies from `chain`
    private func getSpecies(from chain: PokemonEvolutionChain.Chain) -> [PokemonNameURL] {
        var allSpecies: [PokemonNameURL] = []
        guard let species = chain.species else { return allSpecies }
        allSpecies.append(species)
        
        guard let nextChain = chain.evolvesTo?.first else { return allSpecies }
        allSpecies.append(contentsOf: getSpecies(from: nextChain))
        return allSpecies
    }
}

struct PokemonEvolutionChainItem: Hashable, Identifiable {
    var id: Int
    var name: String?
    var imageUrl: String?
    var gradientColors: [Color]
}
