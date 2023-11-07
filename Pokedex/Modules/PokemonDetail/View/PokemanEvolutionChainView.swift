//
//  PokemanEvolutionChainView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanEvolutionChainView: View {
    
    let viewmodel: PokemanEvolutionChainViewModel
    @Binding var pokemonEvolutionChainItemList: [PokemonEvolutionChainItem]?
    @Binding var selectedPokemonId: Int
    
    init(selectedPokemonId: Binding<Int>,
         pokemonNavigation: PokemonBottomNavigation,
         pokemonEvolutionChainItemList: Binding<[PokemonEvolutionChainItem]?>) {
        self._selectedPokemonId = selectedPokemonId
        self.viewmodel = PokemanEvolutionChainViewModel(pokemonNavigation: pokemonNavigation)
        self._pokemonEvolutionChainItemList = pokemonEvolutionChainItemList
    }
    
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                Text(DetailScreenLabels.evolutionChainLabel)
                    .font(AppFont.subtitle)
                    .fontWeight(.bold)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(pokemonEvolutionChainItemList ?? [], id: \.id) { item in
                            ImageViewWithGradient(imageURL: item.imageUrl ?? "", gradientColors: item.gradientColors)
                                .aspectRatio(0.7, contentMode: .fit)
                            
                            if pokemonEvolutionChainItemList?.last?.id != item.id {
                                AppImages.rightArrow
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center) {
                    ButtonWithLabel(disabled: viewmodel.shouldDisablePreviousButton()) {
                        Label(viewmodel.getPreviousPokemanName(), systemImage: "arrow.backward")
                    } action: {
                        if let id = viewmodel.getPreviousPokemanId() {
                            updateSelectPokemonID(id)
                        }
                    }
                    Spacer()
                    ButtonWithLabel(disabled: viewmodel.shouldDisableNextButton()) {
                        Label(viewmodel.getNextPokemanName(), systemImage: "arrow.right")
                            .labelStyle(TitleIconLabelStyle())
                    } action: {
                        updateSelectPokemonID(viewmodel.getNextPokemanId())
                    }
                }
            }
        }
    }
    
    func updateSelectPokemonID(_ id: Int) {
        selectedPokemonId = id
    }
}

struct PokemanEvolutionChainView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanEvolutionChainView(selectedPokemonId: .constant(2),
                                  pokemonNavigation: .init(previousPokemon: nil, nextPokemon: nil, selectedPokemon: .dummy),
                                  pokemonEvolutionChainItemList: .constant(nil))
    }
}
