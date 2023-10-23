//
//  PokemanAbilityView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanAbilityView: View {
    
    let eggGroup = "bug"
    let abilities = ["swarm, sniper"]
    let types = ["bug", "poison"]
    let weekAgainst = ["fire", "rock", "ground", "psychic", "flying"]
    let pokemonDetail: PokemonDetail

    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Height").fontWeight(.bold)
                            Text("\(pokemonDetail.height)")
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Gender(s)").fontWeight(.bold)
                            Text("\(PokemonGenderManager.shared.getGender(for: pokemonDetail.name ?? ""))")
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Abilities").fontWeight(.bold)
                            let abilitiesArr = abilities.joined(separator: ", ")
                            Text("\(abilitiesArr)")
                        }
                        .padding(.bottom)
                        
                    }
                    .frame(width: geometry.size.width * 0.4)
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            Text("Weight").fontWeight(.bold)
                            Text("\(pokemonDetail.weight)")
                        }
                        .padding(.bottom)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Egg Groups").fontWeight(.bold)
                            Text(eggGroup)
                        }
                        .padding(.bottom)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Types").fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: true) {
                                LazyHGrid(rows: [GridItem(.adaptive(minimum: 40))]) {
                                    ForEach(types, id: \.self) { item in
                                        Text(item)
                                            .padding(.horizontal, 8)
                                            .background(.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(6)
                                    }
                                }
                            }
                        }
                        .frame(height: 70)
                        .padding(.bottom)
                    }
                    .frame(width: geometry.size.width * 0.4)
                }
                
                VStack() {
                    Text("Week Against").fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 40))]) {
                            ForEach(weekAgainst, id: \.self) { item in
                                Text(item)
                                    .padding(.horizontal, 8)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                        }
                    }
                }.padding()
            }
        }
    }
}

struct PokemanAbilityView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanAbilityView(pokemonDetail: .dummy)
    }
}
