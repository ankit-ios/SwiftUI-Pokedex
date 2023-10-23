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
    @Published var pokemonsDetail: [PokemonItem: PokemonDetail] = [:]
    @Published var searchQuery: String = ""
    
    private var cancellable: AnyCancellable?
    
    //Pagignation logic
    private var nextPage: String?
    private var offset: Int = 0
    private var limit: Int = 20
    
    var isFetchingData: Bool = false
    
    init() {
        setupSearchPublisher()
        _ = PokemonGenderManager.shared //TODO
    }
    
    private func setupSearchPublisher() {
        cancellable = $searchQuery
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] text in
                self?.performSearch()
            })
    }
    
    func performSearch() {
        filteredPokemons = searchQuery.isEmpty ? allPokemons : allPokemons
            .filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    }
    
    func fetchPokemonList(from networkManager: NetworkManager) {
        isFetchingData = true
        networkManager.request(PokemonApi.list(offset: offset, limit: limit), responseType: PokemonListResponse.self)
              .sink(receiveCompletion: { _ in }) { newData in
                  print(newData)
                  self.allPokemons = newData.results
                  self.offset += 20
                  self.performSearch()
                  self.isFetchingData = false
              }
              .store(in: &networkManager.cancellables)
      }
    
    func fetchNextPagePokemonList(from networkManager: NetworkManager) {
        isFetchingData = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            networkManager.request(PokemonApi.list(offset: self.offset, limit: self.limit), responseType: PokemonListResponse.self)
                .sink(receiveCompletion: { _ in }) { newData in
                    //                  print(newData)
                    self.allPokemons.append(contentsOf: newData.results)
                    self.offset += 20
                    self.performSearch()
                    self.isFetchingData = false
                }
                .store(in: &networkManager.cancellables)
        }
      }
    
    func fetchPokemonItemImage(_ item: PokemonItem, from networkManager: NetworkManager) {
        
        guard !pokemonsDetail.contains(where: {$0.key.name == item.name}),
              let id = getId(from: item.url) else { return }
        
        networkManager.request(PokemonApi.detail(id: id), responseType: PokemonDetail.self)
            .sink(receiveCompletion: { _ in }) { detail in
                print(detail)
                self.pokemonsDetail[item] = detail
                if let index = self.allPokemons.firstIndex (where: { $0.name == item.name }) {
                    self.allPokemons[index].thumbnail = detail.sprites.thumbnail
                }
            }
            .store(in: &networkManager.cancellables)
    }
    
    func getId(from urlString: String) -> Int? {
        if let url = URL(string: urlString),
           let id = Int(url.lastPathComponent) {
            return id
        }
        return nil
    }
    
    func getPokemonDetail(for item: PokemonItem) -> PokemonDetail? {
        pokemonsDetail.first(where: { $0.key.name == item.name })?.value
    }
    
    func hasReachedEnd(of item: PokemonItem) -> Bool {
        filteredPokemons.last?.name == item.name
    }
}
