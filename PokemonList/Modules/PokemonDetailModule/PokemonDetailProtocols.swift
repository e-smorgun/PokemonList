//
//  PokemonDetailProtocols.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

protocol PokemonDetailInteractorProtocol {
    var urlData: String { get set }
    func fetchPokemonDetail(completion: @escaping (Result<PokemonResult, Error>) -> Void)
}
