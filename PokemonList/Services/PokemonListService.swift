//
//  PokemonsService.swift
//  PokemonList
//
//  Created by Evgeny on 16.02.24.
//

import Foundation

class PokemonListService {
    private let dataService = DataService()

    func fetchList(url: String? = nil, completion: @escaping (Result<PokemonListResult, Error>) -> Void) {
        let urlString = url ?? "https://pokeapi.co/api/v2/pokemon"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        dataService.fetchModel(from: url, completion: completion)
    }
}
