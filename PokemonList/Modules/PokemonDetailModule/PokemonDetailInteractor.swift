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

    var urlData: String
    
    init(service: PokemonDetailService, urlData: String) {
          self.service = service
          self.urlData = urlData
      }
    
    func fetchPokemonDetail(completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        print("URL: ", urlData)
        service.fetchDetail(url: urlData, completion: completion)
    }
}
