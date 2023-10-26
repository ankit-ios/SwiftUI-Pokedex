//
//  PokemonDetailViewModelTests.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest
import Combine
@testable import Pokedex

class PokemonDetailViewModelTests: XCTestCase {
    var viewModel: PokemonDetailViewModel!
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        viewModel = PokemonDetailViewModel()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        viewModel = nil
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchPokemonData() {
        let pokemonId = 1 // Replace with a valid Pokemon ID
        let expectation = XCTestExpectation(description: "Fetch Pokemon Data")
        
        viewModel.fetchPokemonData(pokemonId: pokemonId, from: networkManager)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Replace 5 with an appropriate timeout for your API calls
            XCTAssertNotNil(self.viewModel.pokemonSpeciesModel)
            XCTAssertNotNil(self.viewModel.pokemonTypeDetailModel)
            XCTAssertNotNil(self.viewModel.pokemonEvolutionChainModel)
            XCTAssertNotNil(self.viewModel.pokemonEvolutionChainItemList)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10) // Replace 10 with an appropriate timeout
    }
    
    func testFetchPokemonEvolutionChainList() {
        
    }
    
    func testFetchPokemonEvolutionChainDetail() {
        
    }
    
    
}
