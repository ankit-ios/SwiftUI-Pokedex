//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import Foundation
import SwiftUI

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
    
    var gradientColors: [Color] {
        let name = types.map { (PokemonType(rawValue: $0.type?.name ?? "normal") ?? PokemonType.water).actionColorHex }
        return name.map { Color(hex: $0) }
    }
    
    static let dummy: PokemonDetail = .init(id: 1, name: "bulbasaur", height: 122, weight: 233, sprites: .init(thumbnail: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", other: .init(home: .init(frontImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"))), types: [.init(slot: 1, type: .init(name: "grass", url: "https://pokeapi.co/api/v2/type/12/"))], abilities: [.init(isHidden: false, slot: 1, ability: .init(name: "shield-dust", url: "https://pokeapi.co/api/v2/ability/19/"))], stats: [.init(baseStat: 30, effort: 1, stat: .init(name: "HP", url: nil)), .init(baseStat: 40, effort: 1, stat: .init(name: "special-defense", url: nil)), .init(baseStat: 70, effort: 1, stat: .init(name: "special-attack", url: nil))])
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
    let speciesDetails: [PokemonGenderSpeciesDetails]?
    var allSpecies: [String] {
        speciesDetails?.compactMap { $0.pokemonSpecies?.name } ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case gender = "name"
        case speciesDetails = "pokemon_species_details"
    }
}

extension PokemonGenderResponse {
    struct PokemonGenderSpeciesDetails: Decodable {
        let pokemonSpecies: PokemonGenderSpecies?
        
        enum CodingKeys: String, CodingKey {
            case pokemonSpecies = "pokemon_species"
        }
    }
    
    struct PokemonGenderSpecies: Decodable {
        let name: String?
    }
}

//MARK: - Species

struct PokemonSpecies: Decodable {
    let eggGroup: [PokemonNameURL]?
    let flavorTextEntries: [FlavorTextEntries]?
    
    
    enum CodingKeys: String, CodingKey {
        case eggGroup = "egg_groups"
        case flavorTextEntries = "flavor_text_entries"
    }
}

extension PokemonSpecies {
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

//MARK: - EvolutionChain

struct PokemonEvolutionChain: Decodable {
    
    let babyTriggerItem: String?
    let chain: Chain?
    let id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain
        case id
    }
}

extension PokemonEvolutionChain {
    struct Chain: Decodable {
        let evolutionDetails: [EvolutionDetails]?
        let evolvesTo: [Chain]?
        let isBaby: Bool?
        let species: PokemonNameURL?
        
        private enum CodingKeys: String, CodingKey {
            case evolutionDetails = "evolution_details"
            case evolvesTo = "evolves_to"
            case isBaby = "is_baby"
            case species
        }
    }
    
    struct EvolutionDetails: Decodable {
        let minLevel: Int?
        let gender: String?
        
        private enum CodingKeys: String, CodingKey {
            case minLevel = "min_level"
            case gender = "gender"
        }
    }
}
