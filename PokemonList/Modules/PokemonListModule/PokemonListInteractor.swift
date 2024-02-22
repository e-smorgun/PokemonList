//
//  PokemonListInteractor.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation

class PokemonListInteractor: PokemonListInteractorProtocol {
    private let service: PokemonListService

    init(service: PokemonListService) {
        self.service = service
    }

    func fetchPokemons(url: String?, completion: @escaping (Result<PokemonListResult, Error>) -> Void) {
        service.fetchList(url: url, completion: completion)
    }
}
