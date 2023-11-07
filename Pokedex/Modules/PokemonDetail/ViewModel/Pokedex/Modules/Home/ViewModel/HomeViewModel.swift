//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var allPokemons: [PokemonItem] = []
    @Published var filteredPokemons: [PokemonItem] = []
    @Published var pokemonsDetails: [PokemonItem: PokemonDetail] = [:]
    @Published var searchQuery: String = ""
    @Published var isFetchingData: Bool = false
    
    private let pokemonListService: PokemonListService
    private var cancellable: AnyCancellable?
    
    init(pokemonListService: PokemonListService) {
        self.pokemonListService = pokemonListService
        setupSearchPublisher()
    }
    
    @MainActor func fetchPokemonList() async {
        isFetchingData = true
        await self.pokemonListService.fetchPokemonList { response in
            switch response {
            case .success(let list):
                self.allPokemons = list.results
                self.performSearch()
                self.isFetchingData = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor func fetchNextPagePokemonList() async {
        isFetchingData = true
        try? await Task.sleep(for: .seconds(2))
        await self.pokemonListService.fetchNextPagePokemonList { response in
            switch response {
            case .success(let list):
                self.allPokemons.append(contentsOf: list.results)
                self.performSearch()
                self.isFetchingData = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPokemonItemDetail(_ item: PokemonItem) async {
        guard !pokemonsDetails.contains(where: {$0.key.name == item.name}),
              let id = item.url.getId() else { return }
        
        await self.pokemonListService.fetchPokemonItemDetail(pokemonId: id, item) { response in
            switch response {
            case .success(let itemDetail):
                self.pokemonsDetails[item] = itemDetail
                if let index = self.allPokemons.firstIndex(where: { $0.name == item.name }) {
                    self.allPokemons[index].thumbnail = itemDetail.sprites.thumbnail
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func hasReachedEnd(of item: PokemonItem) -> Bool {
        guard searchQuery.isEmpty else { return false }
        return allPokemons.last?.name == item.name
    }
    
    func performSearch() {
        filteredPokemons = searchQuery.isEmpty ? allPokemons : allPokemons
            .filter { $0.name.lowercased().contains(searchQuery.lowercased()) ||
                "\($0.url.getId() ?? -1)" == searchQuery }
    }
}

// MARK: - Utility methods
extension HomeViewModel {
    
    func setupSearchPublisher() {
        cancellable = $searchQuery
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] _ in
                self?.performSearch()
            })
    }
    
    func getPokemonDetail(for item: PokemonItem) -> PokemonDetail? {
        pokemonsDetails.first(where: { $0.key.name == item.name })?.value
    }
    
    func getPokemon(for id: Int) -> (item: PokemonItem?, detail: PokemonDetail?) {
        if let item = pokemonsDetails.first(where: { $0.key.url.getId() == id }) {
            return (item.key, item.value)
        }
        return (nil, nil)
    }
}
