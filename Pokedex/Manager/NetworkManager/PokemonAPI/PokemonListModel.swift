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
    
    static let dummy: PokemonDetail = .init(id: 1, name: "", height: 122, weight: 233, sprites: .init(thumbnail: nil, other: .init(home: .init(frontImage: nil))), types: [])
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
    let type: PokemonName?
}

struct PokemonName: Decodable {
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

