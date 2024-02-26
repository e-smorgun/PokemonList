//
//  CacheManagerTests.swift
//  CacheManagerTests
//
//  Created by Evgeny on 26.02.24.
//

import XCTest

@testable import PokemonList

class CacheManagerTests: XCTestCase {

    var cacheManager: CacheManager!
    let cacheFileName = "charizard"
    var cachePath: URL!

    override func setUpWithError() throws {
        cacheManager = CacheManager()
        
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cachePath = cachesDirectory.appendingPathComponent(cacheFileName)
        
        if FileManager.default.fileExists(atPath: cachePath.path) {
            try FileManager.default.removeItem(at: cachePath)
        }
    }

    override func tearDownWithError() throws {
        cacheManager = nil
    }

    func testSaveToCache() throws {
        let testData = "Test data".data(using: .utf8)!
        
        cacheManager.saveToCache(cachePath: cachePath, data: testData)
        
        XCTAssertTrue(FileManager.default.fileExists(atPath: cachePath.path), "Cache file should exist after saving")
    }
    
    func testLoadFromCache() throws {
        let testData = "Test data".data(using: .utf8)!
        try testData.write(to: cachePath)
        
        let loadedData = cacheManager.loadFromCache(cachePath: cachePath)
        
        XCTAssertNotNil(loadedData, "Loaded data should not be nil")
        XCTAssertEqual(loadedData, testData, "Loaded data should match saved data")
    }
    
    func testLoadFromNonExistingCache() throws {
        let loadedData = cacheManager.loadFromCache(cachePath: cachePath)
        
        XCTAssertNil(loadedData, "Loaded data should be nil if cache file doesn't exist")
    }
}
