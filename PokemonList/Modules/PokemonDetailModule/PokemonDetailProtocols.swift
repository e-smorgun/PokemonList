//
//  PokemonDetailProtocols.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

protocol PokemonDetailPresenterProtocol {
    
}

protocol PokemonDetailRouterProtocol {
    
}

protocol PokemonDetailInteractorProtocol {
    var UrlData: String { get set }
    func fetchPokemons(completion: @escaping (Result<PokemonResult, Error>) -> Void)
}
