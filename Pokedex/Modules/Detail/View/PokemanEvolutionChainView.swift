//
//  PokemanEvolutionChainView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanEvolutionChainView: View {
    
    let imageURL = "https://mcdn.wallpapersafari.com/medium/80/94/3kEq8V.jpeg"
    let pokemonDetail: PokemonDetail


    var body: some View {
        VStack(alignment: .leading) {
            Text("Evolution Chain")
                .fontWeight(.heavy)
                .font(.system(size: 24))

            HStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .overlay(AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            VStack {
                                image
                                    .resizable()
                                    .frame(width: 100)
                                    .aspectRatio(contentMode: .fit)
                            }

                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            EmptyView()
                        }
                    })
                    .frame(width: 100, height: 200)
                    .dottedBorder(color: .black, lineWidth: 2, dash: [5, 5])

                
                Image(systemName: "arrow.right")
                
                RoundedRectangle(cornerRadius: 10)
                    .overlay(AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            VStack {
                                image
                                    .resizable()
                                    .frame(width: 100)
                                    .aspectRatio(contentMode: .fit)
                            }

                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            EmptyView()
                        }
                    })
                    .frame(width: 100, height: 200)

                    .dottedBorder(color: .black, lineWidth: 2, dash: [5, 5])

                
                Image(systemName: "arrow.right")
                
                RoundedRectangle(cornerRadius: 10)
                    .overlay(AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            VStack {
                                image
                                    .resizable()
                                    .frame(width: 100)
                                    .aspectRatio(contentMode: .fit)
                            }

                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            EmptyView()
                        }
                    })
                    .frame(width: 100, height: 200)
                    .dottedBorder(color: .black, lineWidth: 2, dash: [5, 5])
            }
            Spacer()
        }
    }
}

struct PokemanEvolutionChainView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanEvolutionChainView(pokemonDetail: .dummy)
    }
}
