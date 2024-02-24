//
//  PokemonAPI.swift
//  PokemonList
//
//  Created by Evgeny on 24.02.24.
//

import Foundation

struct PokemonAPI {
    private static let baseURLString = "https://pokeapi.co/api/"
    private static let version = "v2"
    private static let resource = "pokemon"
    
    static var baseURL: URL {
        return URL(string: baseURLString)!
    }
    
    static var versionURL: URL {
        return baseURL.appendingPathComponent(version)
    }
    
    static var pokemonListURL: URL {
        return versionURL.appendingPathComponent(resource)
    }
    
    static func pokemonDetailURL(forID id: String) -> URL {
        return versionURL.appendingPathComponent("\(resource)/\(id)")
    }
}
