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
        let fetchURL: URL
        if let urlString = url, let providedURL = URL(string: urlString) {
            fetchURL = providedURL
        } else {
            fetchURL = PokemonAPI.pokemonListURL
        }
        
        if Reachability.isConnectedToNetwork() {
            dataService.fetchModel(from: fetchURL, completion: completion)
        } else {
            dataService.fetchCachedModell(from: fetchURL, completion: completion)
        }
    }
}
