//
//  PokemonDetailPresenter.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

final class PokemonDetailPresenter: ObservableObject, PokemonDetailPresenterProtocol {
    private let interactor: PokemonDetailInteractorProtocol

    @Published var pokemon: PokemonResult?
    @Published var error: String = ""
    @Published var isLoading: Bool = true
    
    init(interactor: PokemonDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetchPokemonData() {
        isLoading = true
        
        interactor.fetchPokemonDetail() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.pokemon = response
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.error = "Failed to fetch pokemon detail: \(error.localizedDescription)"
                    print("Failed to fetch pokemon list: \(error.localizedDescription)")
                }
            }
        }
    }
}
