//
//  PokemonDetailResponse.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

//MARK: - Detail
struct PokemonDetail: Decodable {
    let id: Int
    let name: String?
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let types: [PokemonTypes]
    let abilities: [PokemonAbility]
    let stats: [PokemonStats]
    
    var gradientColors: [Color] {
        let name = types.map { (PokemonType(rawValue: $0.type?.name ?? "normal") ?? PokemonType.water) }
        return name.map { $0.color }
    }
}

#if DEBUG

extension PokemonDetail {
    static let dummy: PokemonDetail = .init(id: 1, name: "bulbasaur", height: 122, weight: 233, sprites: .init(thumbnail: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", other: .init(home: .init(frontImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"))), types: [.init(slot: 1, type: .init(name: "grass", url: "https://pokeapi.co/api/v2/type/12/"))], abilities: [.init(isHidden: false, slot: 1, ability: .init(name: "shield-dust", url: "https://pokeapi.co/api/v2/ability/19/"))], stats: [.init(baseStat: 30, effort: 1, stat: .init(name: "HP", url: nil)), .init(baseStat: 40, effort: 1, stat: .init(name: "special-defense", url: nil)), .init(baseStat: 70, effort: 1, stat: .init(name: "special-attack", url: nil))])
}

#endif


struct PokemonStats: Decodable {
    let baseStat: Int?
    let effort: Int?
    let stat: PokemonNameURL?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonAbility: Decodable {
    let isHidden: Bool?
    let slot: Int?
    let ability: PokemonNameURL?
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot
        case ability
    }
}

struct PokemonSprites: Decodable {
    let thumbnail: String?
    let other: PokemonOther
    var actualImage: String? {
        other.home.frontImage
    }
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "front_default"
        case other
    }
}

extension PokemonSprites {
    struct PokemonOther: Decodable {
        let home: PokemonSpritesHome
    }
    
    struct PokemonSpritesHome: Decodable {
        let frontImage: String?
        enum CodingKeys: String, CodingKey {
            case frontImage = "front_default"
        }
    }
}
