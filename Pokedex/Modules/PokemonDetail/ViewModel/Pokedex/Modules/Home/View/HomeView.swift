//
//  HomeView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 19/10/23.
//

import SwiftUI
import FirebasePerformance

struct HomeView: View {
    
    @State private var isFilterSheetPresented = false // To control the filter sheet
    @State private var isPokemonDetailPresented = false // To control the filter sheet
    
    @State private var scrolledToBottom = false
    @State private var selectedPokemonId = -1
    
    @StateObject var viewModel: HomeViewModel
    @State var trace: Trace?
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    init() {
        self._viewModel = StateObject(wrappedValue: .init(pokemonListService: PokemonListServiceManager(.shared)))
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // divider
                Divider()
                    .frame(height: 1)
                    .background(.gray)
                
                // top label
                Text(HomeScreenLabels.searchLabel)
                
                HStack {
                    
                    // search bar
                    SearchBar(searchText: $viewModel.searchQuery, searchAction: {
                        viewModel.performSearch()
                    })
                    
                    // Filter Button
                    Button(action: {
                        isFilterSheetPresented = true
                    }) {
                        AppImages.filter
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: 60, height: 50)
                    .background(AppColors.Text.primary)
                    .cornerRadius(10)
                }
                
                // Pokeman list
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) { // Set spacing here
                        ForEach(viewModel.filteredPokemons, id: \.name) { item in
                            let pokemonItem = viewModel.getPokemonDetail(for: item)
                            PokemonItemView(pokemon: pokemonItem)
                                .frame(height: 200)
                                .id(item.name)
                                .onAppear { handlePagignation(item) }
                                .onTapGesture {
                                    selectedPokemonId = pokemonItem?.id ?? -1
                                }
                        }
                    }
                    .padding()
                }
                .overlay(alignment: .bottom, content: {
                    LoadingView(show: $viewModel.isFetchingData)
                })
                Spacer()
            }
            .onChange(of: selectedPokemonId) { newValue in
                if newValue != -1 {
                    isPokemonDetailPresented = true
                }
            }
            
            // Firebase tracing
            .onAppear { trace = Performance.startTrace(name: "home_view") }
            .onDisappear { trace?.stop() }
            
            .padding()
            .background(AppColors.Background.primary)
            .navigationTitle(AppScreenTitles.home)
            
            // Filter popup
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterView(isFilterSheetPresented: $isFilterSheetPresented)
            }
            
            // Detail screen
            .fullScreenCover(isPresented: $isPokemonDetailPresented) {
                let p = viewModel.getPokemon(for: selectedPokemonId)
                if let detail = p.detail {
                    let vm = PokemonDetailViewModel(
                        pokemonDetailService: PokemonDetailServiceManager(.shared),
                        selectedPokemonId: $selectedPokemonId,
                        selectedPokemon: detail,
                        allPokemonDetails: viewModel.pokemonsDetails)
                    PokemonDetailView(vm: vm, isPokemonDetailPresented: $isPokemonDetailPresented)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonList()
            }
        }
    }
    
    private func handlePagignation(_ item: PokemonItem) {
        Task {
            await viewModel.fetchPokemonItemDetail(item)
            
            // pagignation logic
            if viewModel.hasReachedEnd(of: item) {
                await viewModel.fetchNextPagePokemonList()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
