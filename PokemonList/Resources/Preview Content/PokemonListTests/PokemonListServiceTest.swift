//
//  PokemonListServiceTest.swift
//  PokemonListTests
//
//  Created by Evgeny on 26.02.24.
//

import XCTest

class PokemonListServiceTests: XCTestCase {

    // Mock DataService for testing
    class MockDataService: DataService {
        func fetchModel<T>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
            // Implement mock behavior
        }
        
        func fetchCachedModell<T>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
            // Implement mock behavior
        }
    }
    
    var pokemonListService: PokemonListService!
    var mockDataService: MockDataService!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockDataService()
        pokemonListService = PokemonListService(dataService: mockDataService)
    }
    
    override func tearDown() {
        pokemonListService = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func testFetchList_WithValidURL() {
        // Given
        let expectation = self.expectation(description: "FetchList")
        let validURL = "http://example.com"
        
        // When
        pokemonListService.fetchList(url: validURL) { result in
            // Then
            switch result {
            case .success(let pokemonListResult):
                // Assert expected behavior
                XCTAssertEqual(pokemonListResult.count, 0) // Add your assertions here
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch pokemon list with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchList_WithNilURL() {
        // Given
        let expectation = self.expectation(description: "FetchList")
        
        // When
        pokemonListService.fetchList() { result in
            // Then
            switch result {
            case .success(let pokemonListResult):
                // Assert expected behavior
                XCTAssertEqual(pokemonListResult.count, 0) // Add your assertions here
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch pokemon list with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
