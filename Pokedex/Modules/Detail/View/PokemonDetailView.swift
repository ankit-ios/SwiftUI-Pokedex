//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let pokemonItem: PokemonItem
    let pokemonDetail: PokemonDetail
    
    @Binding var isPokemonDetailPresented: Bool
    @StateObject var viewModel = PokemonDetailViewModel()
    @StateObject var networkManager = NetworkManager.shared

    
    var body: some View {
        ScrollView {
            VStack {
                //Heading view
                PokemonDetailHeadingView(pokemonDetail: pokemonDetail, pokemonSpices: $viewModel.pokemonSpeciesModel)
                    .frame(height: 300)
                    .padding(.bottom)
                    
                Spacer()
                
                //Pokeman Ability view
                PokemanAbilityView(pokemonDetail: pokemonDetail, pokemonSpecies: $viewModel.pokemonSpeciesModel, pokemonTypeDetail: $viewModel.pokemonTypeDetailModel)
                    .frame(height: 320)
                    .padding(.bottom)
                Spacer()
                
                //Pokeman State view
                PokemanStatsView(statsModel: PokemonStatsModel(pokemonDetail: pokemonDetail))
                    .frame(minHeight: 200, maxHeight: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                Spacer()
                
                PokemanEvolutionChainView(pokemonDetail: pokemonDetail, pokemonEvolutionChainModel: $viewModel.pokemonEvolutionChainModel)
                    .frame(height: 320)
                    .padding(.bottom)
                
            } //Outer VStack
            .onAppear {
                viewModel.fetchPokemonData(pokemonId: pokemonDetail.id, from: networkManager)
            }
            .padding()
        }
        .background(Color(hex: "#DEEDED"))
        .navigationTitle(pokemonItem.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) { Image(systemName: "xmark.circle") })
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonItem: .init(name: "ankit", url: ""), pokemonDetail: PokemonDetail.dummy, isPokemonDetailPresented: .constant(false))
    }
}
