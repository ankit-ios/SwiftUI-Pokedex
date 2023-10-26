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
        VStack(alignment: .leading) {
            Text("Evolution Chain")
                .fontWeight(.heavy)
                .font(.system(size: 24))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(pokemonEvolutionChainItemList ?? [], id: \.id) { item in
                        ImageViewWithGradient(imageURL: item.imageUrl ?? "", gradientColors: item.gradientColors)
                            .aspectRatio(0.7, contentMode: .fit)
                        
                        if pokemonEvolutionChainItemList?.last?.id != item.id {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Button {
                    print(pokemonDetail)
                    if let id = viewmodel.getPreviousPokemanId() {
                        print(id)
                    }
                } label: {
                    Text("Previous")
                }
                .foregroundColor(.white)
                .background(.blue)
                
                Spacer()
                Button {
                    print(viewmodel.getNextPokemanId())
                } label: {
                    Text("Next")
                }
                .foregroundColor(.white)
                .background(.blue)
            }
            .padding()
        }
    }
}

struct PokemanEvolutionChainView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanEvolutionChainView.init(pokemonDetail: .dummy, pokemonEvolutionChainItemList: .constant(nil))
    }
}
