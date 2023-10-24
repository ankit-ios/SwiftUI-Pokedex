//
//  PokemanStatsView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanStatsView: View {
    
    let statsModel: PokemonStatsModel
    
    private var stats: [PokemonStatsModel.Stats] {
        statsModel.getPokemenStats()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .fontWeight(.heavy)
                .font(.system(size: 24))
                        
            ForEach(stats, id: \.name) { item in
                
                HStack(alignment: .center, spacing: 2) {
                    Text(item.name.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                    Spacer()
                    ProgressBarView(progress: item.percentage)
                        .frame(height: 20)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct PokemanStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanStatsView(statsModel: .init(pokemonDetail: .dummy))
    }
}
