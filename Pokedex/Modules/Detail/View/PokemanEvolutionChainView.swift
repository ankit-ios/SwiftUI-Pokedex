//
//  PokemanEvolutionChainView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanEvolutionChainView: View {
    
    let pokemonDetail: PokemonDetail
    @Binding var pokemonEvolutionChainModel: PokemonEvolutionChainModel?
    @Binding var pokemonEvolutionChainItemList: [PokemonEvolutionChainItem]?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Evolution Chain")
                .fontWeight(.heavy)
                .font(.system(size: 24))
            
            HStack {
                ForEach(pokemonEvolutionChainItemList ?? [], id: \.id) { item in
                    ImageViewWithGradient(imageURL: item.imageUrl ?? "", gradientColors: item.gradientColors)
                    
                    if pokemonEvolutionChainItemList?.last?.id != item.id {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Button {
                    
                } label: {
                    Text("Previous")
                }
                .foregroundColor(.white)
                .background(.blue)
                
                
                
                
                
                Spacer()
                Button {
                    
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

//struct PokemanEvolutionChainView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemanEvolutionChainView(pokemonDetail: .dummy, pokemonEvolutionChainModel: .constant(nil), pokemonEvolutionChainDetailList: .constant(nil))
//    }
//}
