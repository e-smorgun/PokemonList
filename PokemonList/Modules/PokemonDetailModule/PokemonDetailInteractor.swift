//
//  PokemonDetailInteractor.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    private let service: PokemonDetailService

    var id: String
    
    init(service: PokemonDetailService, id: String) {
          self.service = service
          self.id = id
      }
    
    func fetchPokemonDetail(completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        service.fetchDetail(for: id, completion: completion)
    }
}
