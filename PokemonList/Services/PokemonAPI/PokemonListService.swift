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

    func fetchList(completion: @escaping (Result<PokemonListResult, Error>) -> Void) {
        let fetchURL = PokemonAPI.pokemonListURL
        dataService.fetchModel(from: fetchURL, completion: completion)
    }
}
