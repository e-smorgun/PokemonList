//
//  DataCaching.swift
//  PokemonList
//
//  Created by Evgeny on 22.02.24.
//

import Foundation

class CacheManager {
    func saveToCache(cachePath: URL, data: Data) {
        let fileManager = FileManager.default
        let filePath = cachePath.path
        
        if !fileManager.fileExists(atPath: filePath) {
            do {
                print("data saved in cache")
                try data.write(to: cachePath)
            } catch {
                print("Failed to write to cache: \(error)")
            }
        }
    }
    
    func loadFromCache(cachePath: URL) -> Data? {
        let fileManager = FileManager.default
        let filePath = cachePath.path
        print("data from cache")

        if fileManager.fileExists(atPath: filePath) {
            do {
                let data = try Data(contentsOf: cachePath)
                return data
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
