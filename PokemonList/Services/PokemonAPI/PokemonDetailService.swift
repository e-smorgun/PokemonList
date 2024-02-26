//
//  PokemonService.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation

class PokemonDetailService {
    private let dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func fetchDetail(for id: String, completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        let detailURL = PokemonAPI.pokemonDetailURL(forID: id)
        if Reachability.isConnectedToNetwork() {
            dataService.fetchModel(from: detailURL, completion: completion)
        } else {
            dataService.fetchCachedModell(from: detailURL, completion: completion)
        }
    }
}
