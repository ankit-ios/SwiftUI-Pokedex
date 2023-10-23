//
//  PokemonDetailHeadingView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonDetailHeadingView: View {
    
    let detailText = "Obviously prefers\nhot places. When\nit rains, steam\nis said to spout\nfrom the tip of\nits tail."
    @State private var isExpanded = false
    let pokemonDetail: PokemonDetail
    var gradientColors: [Color] {
        let types = pokemonDetail.types
        let name = types.map { (PokemonType(rawValue: $0.type?.name ?? "normal") ?? PokemonType.water).actionColorHex }
        return name.map { Color(hex: $0) }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            HStack (alignment: .center, spacing: 20) {
                
                AsyncImage(url: (URL(string: pokemonDetail.sprites.actualImage ?? ""))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: geometry.size.width*0.4, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        EmptyView()
                    }
                }
                .addGradient(colors: gradientColors)
                .frame(width: geometry.size.width*0.4, height: geometry.size.height)
                .dottedBorder(color: .black, lineWidth: 1, dash: [5, 5], cornerRadius: 12)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)

                VStack(alignment: .leading, spacing: 10) {
                    Text(detailText)
                        .multilineTextAlignment(.leading)
                        .lineLimit(isExpanded ? nil : 2)
                    
                    //read more/less button
                    Button(action: { withAnimation { isExpanded.toggle() }})
                    {
                        Text(isExpanded ? "Read Less" : "Read More")
                            .foregroundColor(.blue)
                            .underline()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PokemonDetailHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailHeadingView(pokemonDetail: .dummy)
    }
}

