//
//  HomeViewModelTests.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest
@testable import Pokedex

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        viewModel = nil
        networkManager = nil
        super.tearDown()
    }

    func testSearchQuery() {
        // Set a search query
        viewModel.searchQuery = "Pikachu"

        // Ensure that the filteredPokemons array is updated correctly
        XCTAssertEqual(viewModel.filteredPokemons.count, 1)

        // Perform another search
        viewModel.searchQuery = "Bulbasaur"
        XCTAssertEqual(viewModel.filteredPokemons.count, 1)

        // Clear the search query
        viewModel.searchQuery = ""
        XCTAssertEqual(viewModel.filteredPokemons.count, viewModel.allPokemons.count)
    }

    func testFetchPokemonList() {
        let expectation = XCTestExpectation(description: "Fetch Pokemon List")

        viewModel.fetchPokemonList(from: networkManager)

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Assert that allPokemons is not empty
            XCTAssertFalse(self.viewModel.allPokemons.isEmpty)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchNextPagePokemonList() {
        let expectation = XCTestExpectation(description: "Fetch Next Page Pokemon List")

        viewModel.fetchNextPagePokemonList(from: networkManager)

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Assert that allPokemons count has increased
            XCTAssertGreaterThan(self.viewModel.allPokemons.count, 0)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchPokemonItemImage() {
        let item = PokemonItem(name: "Pikachu", url: "https://example.com/pikachu")
        let expectation = XCTestExpectation(description: "Fetch Pokemon Image")

        viewModel.fetchPokemonItemImage(item, from: networkManager)

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Assert that the item is added to pokemonsDetails
            XCTAssertNotNil(self.viewModel.pokemonsDetails[item])

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testGetId() {
        let urlString = "https://example.com/pokemon/25"
        let id = viewModel.getId(from: urlString)
        XCTAssertEqual(id, 25)

        let invalidURL = "invalid-url"
        let invalidId = viewModel.getId(from: invalidURL)
        XCTAssertNil(invalidId)
    }
}
