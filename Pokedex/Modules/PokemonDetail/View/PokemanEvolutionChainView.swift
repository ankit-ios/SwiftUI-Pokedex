//
//  PokemanEvolutionChainView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanEvolutionChainView: View {
    
    let pokemonDetail: PokemonDetail
    let viewmodel: PokemanEvolutionChainViewModel
    @Binding var pokemonEvolutionChainItemList: [PokemonEvolutionChainItem]?
    
    
    init(pokemonDetail: PokemonDetail,
         pokemonEvolutionChainItemList: Binding<[PokemonEvolutionChainItem]?>) {
        self.pokemonDetail = pokemonDetail
        self.viewmodel = PokemanEvolutionChainViewModel(pokemonDetail: pokemonDetail)
        self._pokemonEvolutionChainItemList = pokemonEvolutionChainItemList
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
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
                    ButtonWithLabel(label: DetailScreenLabels.previousLabel) {
                        if let id = viewmodel.getPreviousPokemanId() {
                            print(id)
                        }
                    }
                    
                    Spacer()
                    
                    ButtonWithLabel(label: DetailScreenLabels.nextLabel) {
                        print(viewmodel.getNextPokemanId())
                    }
                }
            }
        }
    }
}

struct PokemanEvolutionChainView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanEvolutionChainView.init(pokemonDetail: .dummy, pokemonEvolutionChainItemList: .constant(nil))
    }
}
