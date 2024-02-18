//
//  PokemonService.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation

class PokemonDetailService {
    private let dataService = DataService()
    
    func fetchDetail(url: String, completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        let url = URL(string: url)!
        dataService.fetchModel(from: url, completion: completion)
    }
}
