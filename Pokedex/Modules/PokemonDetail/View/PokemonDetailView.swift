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
    @StateObject var viewModel: PokemonDetailViewModel
    @StateObject var networkManager: NetworkManager
    @State var isShowFullDetailPresented: Bool = false

    init(pokemonItem: PokemonItem,
         pokemonDetail: PokemonDetail,
         isPokemonDetailPresented: Binding<Bool>,
         networkManager: NetworkManager = NetworkManager.shared) {
        
        self.pokemonItem = pokemonItem
        self.pokemonDetail = pokemonDetail
        self._isPokemonDetailPresented = isPokemonDetailPresented
        self._viewModel = StateObject(wrappedValue: PokemonDetailViewModel())
        self._networkManager = StateObject(wrappedValue: networkManager)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer()
                //Navigation view
                NavigationHeaderView(model: NavigationHeaderItem(title: pokemonItem.name, subTitle: String(format: "00%d", pokemonDetail.id), isPresented: presentationMode))
                    .padding(.horizontal)
                
                //Heading view
                PokemonDetailHeadingView(pokemonDetail: pokemonDetail, pokemonSpices: $viewModel.pokemonSpeciesModel) { fullFlavorTexts in
                    self.viewModel.fullFlavorTexts = fullFlavorTexts
                    self.isShowFullDetailPresented = true
                }
                .frame(height: 300)
                .padding(.horizontal)

                Spacer()
                
                //Pokeman Ability view
                PokemanAbilityView(pokemonDetail: pokemonDetail, pokemonSpecies: $viewModel.pokemonSpeciesModel, pokemonTypeDetail: $viewModel.pokemonTypeDetailModel)
                    .frame(height: 320)
                    .padding()
                Spacer()
                
                //Pokeman State view
                PokemanStatsView(statsModel: PokemonStatsModel(pokemonDetail: pokemonDetail))
                    .frame(minHeight: 200, maxHeight: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                Spacer()
                
                PokemanEvolutionChainView(pokemonDetail: pokemonDetail,
                                          pokemonEvolutionChainItemList: $viewModel.pokemonEvolutionChainItemList)
                .frame(height: 250)
                .padding()
            } //Outer VStack
            .onAppear {
                viewModel.fetchPokemonData(pokemonId: pokemonDetail.id, from: networkManager)
            }
        }
        .background(AppColors.Background.primary)
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowFullDetailPresented) {
            PopupView(isShowingPopup: $isShowFullDetailPresented) {
                Text(viewModel.fullFlavorTexts)
                    .foregroundColor(.white)
                    .font(AppFont.caption)
                    .padding()
            }
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(20)
            .presentationDragIndicator(.visible)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonItem: .init(name: "ankit", url: ""), pokemonDetail: PokemonDetail.dummy, isPokemonDetailPresented: .constant(false))
    }
}
