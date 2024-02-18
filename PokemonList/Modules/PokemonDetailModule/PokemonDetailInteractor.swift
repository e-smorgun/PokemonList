//
//  PokemonDetailInteractor.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    private let service = PokemonDetailService()
    
    var UrlData: String
    
    init(UrlData: String) {
        self.UrlData = UrlData
    }
    
    func fetchPokemons(completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        print("URL: ", UrlData)
        service.fetchDetail(url: UrlData, completion: completion)
    }
}
