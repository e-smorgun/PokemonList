//
//  PokemonListProtocoles.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

protocol PokemonListPresenterProtocol {
    var pokemonList: [Results] { get }
    func fetchPokemonList()
}

protocol PokemonListInteractorProtocol {
    func fetchPokemons(completion: @escaping (Result<PokemonListResult, Error>) -> Void)
}
