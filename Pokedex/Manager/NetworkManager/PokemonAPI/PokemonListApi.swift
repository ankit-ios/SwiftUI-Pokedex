//
//  PokemonApi.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import Foundation

enum PokemonApi: APIRequest {
    case list(offset: Int, limit: Int)
    case detail(id: Int)
    case gender(type: String)
    case species(id: Int)
    case type(id: Int)
    
    var endpoint: String {
        switch self {
        case .list: return "/pokemon"
        case .detail(let id): return "/pokemon/\(id)"
        case .gender(let type): return "/gender/\(type)"
        case .species(let id): return "/pokemon-species/\(id)"
        case .type(let id): return "/type/\(id)"
        }
    }
    
    var requestParameters: [String: Any]? {
        switch self {
        case .list(let offset, let limit):
            return ["offset": offset, "limit": limit]
        default: return nil
        }
    }
}

enum PokemonType: String, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
}

extension PokemonType {
    var actionColorHex: String {
        switch self {
        case .normal:
            return "#DDCBC0"
        case .fighting:
            return "#FCC1B0"
        case .flying:
            return "#B2D2E8"
        case .poison:
            return "#CFB7ED"
        case .ground:
            return "#FAD1E6"
        case .rock:
            return "#C5AEA8"
        case .bug:
            return "#C1E0C8"
        case .ghost:
            return "#D7C2D7"
        case .steel:
            return "#C2D4CE"
        case .fire:
            return "#EDC2C4"
        case .water:
            return "#CBD5ED"
        case .grass:
            return "#C0D4E8"
        case .electric:
            return "#E2E2A0"
        case .psychic:
            return "#DDC0CF"
        case .ice:
            return "#C7D7DF"
        case .dragon:
            return "#CADCDF"
        case .dark:
            return "#C6CFE3"
        case .fairy:
            return "#E4C0CF"
        case .unknown:
            return "#C0EFDD"
        case .shadow:
            return "#CACACA"
        }
    }
}
