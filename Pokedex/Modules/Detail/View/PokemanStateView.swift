//
//  PokemanStateView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanStateView: View {
    
    let pokemonDetail: PokemonDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .fontWeight(.heavy)
                .font(.system(size: 24))
            
            Spacer()
            
            HStack {
                Text("HP")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
                ProgressBarView(progress: 0.78)
            }
            HStack(alignment: .center) {
                Text("Attack")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
                
                ProgressBarView(progress: 0.8)
            }
            HStack(alignment: .center) {
                Text("Defense")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
                
                ProgressBarView(progress: 1)
            }
            HStack(alignment: .center) {
                Text("Speed")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
                
                ProgressBarView(progress: 0.2)
            }
            Spacer()
        }
    }
}

struct PokemanStateView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanStateView(pokemonDetail: .dummy)
    }
}
