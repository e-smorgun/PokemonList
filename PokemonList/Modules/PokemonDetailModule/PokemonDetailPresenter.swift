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

    var pokemon: PokemonResult?
    
    @Published var error: String = ""
    @Published var isLoading: Bool = true
    
    init(interactor: PokemonDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetchPokemonData() {
        isLoading = true
        
        interactor.fetchPokemonDetail() { result in
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
    
    
    func checkData() {
        print("")
        print("Base exp: ", pokemon?.baseExperience)
        print("")
        if let pokemon = pokemon {
            for form in pokemon.forms {
                print("Form name: ", form.name)
            }
        }
        print("")
        print("Height: ", pokemon?.height)
        print("Weight: ", pokemon?.weight)
        print("ID:", pokemon?.id)
        print("Name", pokemon?.name)
        print("")
        
        print("")
        if let pokemon = pokemon {
            for type in pokemon.types {
                print("Type: ", type.type)
            }
        }
    }
}
