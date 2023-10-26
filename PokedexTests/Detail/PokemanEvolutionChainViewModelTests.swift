//
//  PokemanEvolutionChainViewModelTests.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest
@testable import Pokedex


class PokemanEvolutionChainViewModelTests: XCTestCase {
    var viewModel: PokemanEvolutionChainViewModel!
    
    override func setUp() {
        super.setUp()
//        let testPokemonDetail = PokemonDetail(id: 5, name: "TestMon")
//        viewModel = PokemanEvolutionChainViewModel(pokemonDetail: testPokemonDetail)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetPreviousPokemanId() {
        // Test when the current Pokemon ID is greater than 1
        XCTAssertEqual(viewModel.getPreviousPokemanId(), 4)
        
        // Test when the current Pokemon ID is 1
//        let pokemonDetailWithId1 = PokemonDetail(id: 1, name: "FirstMon")
//        let viewModelWithId1 = PokemanEvolutionChainViewModel(pokemonDetail: pokemonDetailWithId1)
//        XCTAssertNil(viewModelWithId1.getPreviousPokemanId())
    }
    
    func testGetNextPokemanId() {
        XCTAssertEqual(viewModel.getNextPokemanId(), 6)
    }
}
