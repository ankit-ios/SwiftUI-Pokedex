//
//  HomeView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 19/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isFilterSheetPresented = false // To control the filter sheet
    @State private var isPokemonDetailPresented = false // To control the filter sheet
    
    @State private var scrolledToBottom = false
    
    
    @StateObject var viewModel = HomeViewModel()
    @StateObject var networkManager = NetworkManager.shared
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                //divider
                Divider()
                    .frame(height: 1)
                    .background(.gray)
                
                //top label
                Text(HomeScreenLabels.searchLabel)
                
                HStack {
                    
                    //search bar
                    SearchBar(searchText: $viewModel.searchQuery, searchAction: {
                        viewModel.performSearch()
                    })
                    
                    // Filter Button
                    Button(action: {
                        isFilterSheetPresented = true
                    }) {
                        Image("filter")
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
                    ScrollViewReader { proxy in
                        
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) { // Set spacing here
                            ForEach(viewModel.filteredPokemons, id: \.name) { item in
                                let itemDetail = viewModel.getPokemonDetail(for: item) ?? .dummy
                                
                                NavigationLink {
                                    //TODO:
                                    PokemonDetailView(pokemonItem: item, pokemonDetail: itemDetail, isPokemonDetailPresented: $isPokemonDetailPresented)
                                } label: {
                                    PokemonItemView(pokemon: item, pokemonDetail: itemDetail)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .frame(height: 200)
                                        .dottedBorder(color: .black, lineWidth: 1, dash: [5, 5], cornerRadius: 12)
                                        .onAppear {
                                            // pagignation logic
                                            if viewModel.hasReachedEnd(of: item) {
                                                withAnimation {
                                                    viewModel.fetchNextPagePokemonList(from: networkManager)
                                                }
                                            }
                                        }
                                }
                                .onAppear {
                                    viewModel.fetchPokemonItemImage(item, from: networkManager)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .overlay(alignment: .bottom, content: {
                    if viewModel.isFetchingData {
                        Text(HomeScreenLabels.loadingMore)
                            .padding()
                            .font(AppFont.caption)
                            .foregroundColor(.white)
                            .background(AppColors.Text.primary)
                            .transition(.opacity)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 10)
                    }
                })
                Spacer()
            }
            .padding()
            .background(AppColors.Background.primary)
            .navigationTitle(AppScreenTitles.home)
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterView(isFilterSheetPresented: $isFilterSheetPresented)
            }
        }
        .onAppear {
            viewModel.fetchPokemonList(from: networkManager)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

