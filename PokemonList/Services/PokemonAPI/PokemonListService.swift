//
//  PokemonsService.swift
//  PokemonList
//
//  Created by Evgeny on 16.02.24.
//

import Foundation

class PokemonListService {
    private let dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }

    func fetchList(url: String? = nil, completion: @escaping (Result<PokemonListResult, Error>) -> Void) {
        if url == nil {
            let fetchURL = PokemonAPI.pokemonListURL
            dataService.fetchModel(from: fetchURL, completion: completion)
        } else {
            dataService.fetchModel(from: URL(string: url!)!, completion: completion)
        }
    }
}
