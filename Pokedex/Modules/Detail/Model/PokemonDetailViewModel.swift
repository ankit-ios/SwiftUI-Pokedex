//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    @Published var pokemonSpicesModel: PokemonSpicesModel?
    @Published var pokemonTypeDetailModel: PokemonTypeDetailModel?
    
    
    init() {
        
    }
    
    func fetchPokemonData(for id: Int, from networkManager: NetworkManager) {
        let speciesRequest = networkManager.request(PokemonApi.species(id: id), responseType: PokemonSpices.self)
        let typeRequest = networkManager.request(PokemonApi.type(id: id), responseType: PokemonTypeDetail.self)
        
        Publishers.Zip(speciesRequest, typeRequest)
            .sink(receiveCompletion: { _ in }) { [weak self] speciesResponse, typeResponse in
                self?.pokemonSpicesModel = PokemonSpicesModel(pokemonSpices: speciesResponse)
                self?.pokemonTypeDetailModel = PokemonTypeDetailModel(pokemonTypeDetail: typeResponse)
            }
            .store(in: &networkManager.cancellables)
    }
}

struct PokemonSpicesModel {
    
    private let pokemonSpices: PokemonSpices
    
    init(pokemonSpices: PokemonSpices) {
        self.pokemonSpices = pokemonSpices
    }
    
    func getFlavorText() -> String {
        pokemonSpices.flavorTextEntries?.filter { $0.language?.name == "en" }.first?.flavorText ?? ""
    }
    
    func getEggGroups() -> [String] {
        pokemonSpices.eggGroup?.compactMap { $0.name } ?? []
    }
}

struct PokemonTypeDetailModel {
    
    private let pokemonTypeDetail: PokemonTypeDetail
    
    init(pokemonTypeDetail: PokemonTypeDetail) {
        self.pokemonTypeDetail = pokemonTypeDetail
    }
    
    func getPokemenWeakAgainst() -> [String] {
        guard let relation = pokemonTypeDetail.damageRelations else { return [] }
        
        let allDamageTypes = (relation.doubleDamageFrom ?? []) + (relation.halfDamageFrom ?? []) + (relation.doubleDamageTo ?? []) + (relation.halfDamageTo ?? [])
        
        let uniqueDamageTypes = Array(Set(allDamageTypes.compactMap { $0.name }))
        
        return uniqueDamageTypes
    }
}

struct PokemonStatsModel {
    
    struct Stats {
        let id = UUID()
        let name: String
        let percentage: Int
    }
    
    private let pokemonDetail: PokemonDetail
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    func getPokemenStats() -> [PokemonStatsModel.Stats] {
        let statsArray: [Stats] = pokemonDetail.stats.compactMap { stat in
            guard let name = stat.stat?.name else { return nil }
            return Stats(name: name, percentage: stat.baseStat ?? 0)
        }
        
        return statsArray
    }
}