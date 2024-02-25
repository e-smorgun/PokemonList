//
//  PokemonListResult.swift
//  PokemonList
//
//  Created by Evgeny on 16.02.24.
//

import Foundation

// MARK: - PokemonsResult
struct PokemonListResult: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Results]
}

// MARK: - Result
struct Results: Decodable, Identifiable, Equatable {
    let name: String
    let url: String
    
    var id: String {
        name
    }
}
