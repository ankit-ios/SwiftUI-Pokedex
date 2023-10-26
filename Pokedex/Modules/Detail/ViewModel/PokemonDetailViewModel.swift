//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    @Published var pokemonSpeciesModel: PokemonSpeciesModel?
    @Published var pokemonTypeDetailModel: PokemonTypeDetailModel?
    @Published var pokemonEvolutionChainModel: PokemonEvolutionChainModel?
    @Published var pokemonEvolutionChainItemList: [PokemonEvolutionChainItem]?
    
    private let dispatchGroup = DispatchGroup()
    private var chainDetailList: [PokemonDetail] = []
    var fullFlavorTexts = ""
    
    
    func fetchPokemonData(pokemonId: Int, from networkManager: NetworkManager) {
        let speciesRequest = networkManager.request(PokemonApi.species(pokemonId: pokemonId), responseType: PokemonSpecies.self)
        let typeRequest = networkManager.request(PokemonApi.type(pokemonId: pokemonId), responseType: PokemonTypeDetail.self)
        let evolutionRequest = networkManager.request(PokemonApi.evolutionChain(pokemonId: pokemonId), responseType: PokemonEvolutionChain.self)
        
        Publishers.Zip3(speciesRequest, typeRequest, evolutionRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure(let error):
                    // An error occurred in one of the requests.
                    print("API Request Error: \(error)")
                }
            }) { [weak self] (speciesResponse, typeResponse, evolutionResponse) in
                
                self?.pokemonSpeciesModel = PokemonSpeciesModel(pokemonSpecies: speciesResponse)
                self?.pokemonTypeDetailModel = PokemonTypeDetailModel(pokemonTypeDetail: typeResponse)
                let evolutionChainModel = PokemonEvolutionChainModel(pokemonEvolutionChain: evolutionResponse)
                self?.pokemonEvolutionChainModel = evolutionChainModel
                self?.fetchPokemonEvolutionChainList(for: evolutionChainModel, from: networkManager)
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchPokemonEvolutionChainList(for pokeman: PokemonEvolutionChainModel?, from networkManager: NetworkManager) {
        if let species = pokeman?.getAllSpecies() {
            species.forEach { pokeman in
                fetchPokemonEvolutionChainDetail(for: pokeman, from: networkManager)
            }
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.pokemonEvolutionChainItemList = self?.chainDetailList.map {
                    PokemonEvolutionChainItem.init(id: $0.id, name: $0.name, imageUrl: $0.sprites.thumbnail, gradientColors: $0.gradientColors)
                } ?? []
            }
        }
    }
    
    
    func fetchPokemonEvolutionChainDetail(for pokeman: PokemonNameURL, from networkManager: NetworkManager) {
        dispatchGroup.enter()
        
        networkManager.request(PokemonApi.detail(pokemonId: pokeman.name ?? ""), responseType: PokemonDetail.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure(let error):
                    // An error occurred in one of the requests.
                    print("API Request Error: \(error)")
                }
            }) { [weak self] (response) in
                self?.chainDetailList.append(response)
                self?.dispatchGroup.leave()
            }
            .store(in: &networkManager.cancellables)
        
    }
}
