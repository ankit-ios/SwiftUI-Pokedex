//
//  PokemanAbilityView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanAbilityView: View {
        
    let pokemonDetail: PokemonDetail
    @Binding var pokemonSpices: PokemonSpicesModel?
    @Binding var pokemonTypeDetail: PokemonTypeDetailModel?

    
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
                            
                            let abilitiesArr = pokemonDetail.abilities
                                .compactMap { $0.ability?.name }
                                .joined(separator: ", ")
                            Text("\(abilitiesArr)")
                        }
                        .padding(.bottom)
                        
                    }
                    .frame(width: geometry.size.width * 0.5)
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            Text("Weight").fontWeight(.bold)
                            Text("\(pokemonDetail.weight)")
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Egg Groups").fontWeight(.bold)
                            Text(pokemonSpices?.getEggGroups().joined(separator: ", ") ?? "")
                        }
                        .padding(.bottom)
                        
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Types").fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: true) {
                                let types = pokemonDetail.types.compactMap { $0.type?.name }
                                LazyHGrid(rows: [GridItem(.adaptive(minimum: 20))]) {
                                    ForEach(types, id: \.self) { item in
                                        Text(item)
                                            .padding(.init(top: 2, leading: 8, bottom: 2, trailing: 8))
                                            .background(Color(hex: (PokemonType(rawValue: item) ?? .normal).actionColorHex))
                                            .foregroundColor(.black)
                                            .cornerRadius(6)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(Color.black, lineWidth: 1)
                                            )
                                    }
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(.bottom)
                    }
                    .frame(width: geometry.size.width * 0.5)
                }
                
                VStack(alignment: .leading) {
                    Text("Week Against").fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 20))]) {
                            let weekAgainst = pokemonTypeDetail?.getPokemenWeakAgainst() ?? []
                            ForEach(weekAgainst, id: \.self) { item in
                                Text(item)
                                    .padding(.init(top: 2, leading: 8, bottom: 2, trailing: 8))
                                    .background(Color(hex: (PokemonType(rawValue: item) ?? .normal).actionColorHex))
                                    .foregroundColor(.black)
                                    .cornerRadius(6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .frame(height: 30)
                }.padding()
            }
        }
    }
}

struct PokemanAbilityView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanAbilityView(pokemonDetail: .dummy, pokemonSpices: .constant(nil), pokemonTypeDetail: .constant(nil))
    }
}
