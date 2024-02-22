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
    
    func fetchDetail(url: String, completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        dataService.fetchModel(from: url, completion: completion)
    }
}
