//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import Foundation

//MARK: - List
struct PokemonListResponse: Decodable {
    let next: String
    let results: [PokemonItem]
}

struct PokemonItem: Decodable, Hashable, Equatable {
    let name: String
    let url: String
    var thumbnail: String?
}


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
    
    static let dummy: PokemonDetail = .init(id: 1, name: "bulbasaur", height: 122, weight: 233, sprites: .init(thumbnail: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", other: .init(home: .init(frontImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"))), types: [.init(slot: 1, type: .init(name: "grass", url: "https://pokeapi.co/api/v2/type/12/"))], abilities: [.init(isHidden: false, slot: 1, ability: .init(name: "shield-dust", url: "https://pokeapi.co/api/v2/ability/19/"))], stats: [])
}


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

struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonNameURL?
}

struct PokemonNameURL: Decodable {
    let name: String?
    let url: String?
}


//MARK: - Gender

struct PokemonGenderResponse: Decodable {
    let gender: String
    let spicesDetails: [PokemonGenderSpicesDetails]?
    var allSpices: [String] {
        spicesDetails?.compactMap { $0.pokemonSpecies?.name } ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case gender = "name"
        case spicesDetails = "pokemon_species_details"
    }
}

extension PokemonGenderResponse {
    struct PokemonGenderSpicesDetails: Decodable {
        let pokemonSpecies: PokemonGenderSpecies?
        
        enum CodingKeys: String, CodingKey {
            case pokemonSpecies = "pokemon_species"
        }
    }
    
    struct PokemonGenderSpecies: Decodable {
        let name: String?
    }
}

//MARK: - Spices

struct PokemonSpices: Decodable {
    let eggGroup: [PokemonNameURL]?
    let flavorTextEntries: [FlavorTextEntries]?
    
    
    enum CodingKeys: String, CodingKey {
        case eggGroup = "egg_groups"
        case flavorTextEntries = "flavor_text_entries"
    }
}

extension PokemonSpices {
    struct FlavorTextEntries: Decodable {
        let flavorText: String?
        let language: PokemonNameURL?
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
}

//MARK: - Type

struct PokemonTypeDetail: Decodable {
    
    let damageRelations: DamageRelations?
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
    }
}

extension PokemonTypeDetail {
    struct DamageRelations: Decodable {
        let doubleDamageFrom: [PokemonNameURL]?
        let halfDamageFrom: [PokemonNameURL]?
        let doubleDamageTo: [PokemonNameURL]?
        let halfDamageTo: [PokemonNameURL]?
        
        enum CodingKeys: String, CodingKey {
            case doubleDamageFrom = "double_damage_from"
            case halfDamageFrom = "half_damage_from"
            case doubleDamageTo = "double_damage_to"
            case halfDamageTo = "half_damage_to"
        }
    }
}
