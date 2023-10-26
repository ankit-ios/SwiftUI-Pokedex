//
//  PokemonGenderManager.swift
//  Pokedex
//
//  Created by Ankit Sharma on 22/10/23.
//

import Foundation
import Combine

enum PokemonGender: String, CaseIterable {
    case female
    case male
    case genderless
}

class PokemonGenderManager {
    static let shared = PokemonGenderManager()

    private let networkManager: NetworkManager
    private var genderDataSource: [PokemonGender: [String]] = [:]

    private init() {
        networkManager = NetworkManager.shared
    }

    
    func fetchGenderData() {
        let requests = PokemonGender.allCases.map { gender in
            networkManager.request(PokemonApi.gender(type: gender.rawValue), responseType: PokemonGenderResponse.self)
        }

        Publishers.MergeMany(requests)
            .sink(receiveCompletion: { _ in }) { [weak self] response in
                if let gender = PokemonGender(rawValue: response.gender) {
                    self?.genderDataSource[gender] = response.allSpecies
                }
            }
            .store(in: &networkManager.cancellables)
    }
}

extension PokemonGenderManager {
    func getGender(for pokemanName: String) -> String {
        if let foundGender = genderDataSource.first(where: { $0.value.contains(pokemanName) }) {
            return foundGender.key.rawValue
        } else {
            return PokemonGender.genderless.rawValue
        }
    }
}
