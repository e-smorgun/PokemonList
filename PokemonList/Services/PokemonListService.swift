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
        let urlString = url ?? "https://pokeapi.co/api/v2/pokemon"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        dataService.fetchModel(from: url, completion: completion)
    }
}
