//
//  PokemonListPresenter.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

final class PokemonListPresenter: ObservableObject, PokemonListPresenterProtocol {
    private let router = PokemonListRouter()
    private let interactor: PokemonListInteractorProtocol
    
    private var nextURL: String = ""
    @Published var error: String = ""
    @Published var isLoading: Bool = true
    
    @Published var pokemonList: [Results] = []
    
    enum Constants {
        static let failedToFetchPokemonList = NSLocalizedString("failed_to_fetch_pokemon_list", comment: "")
    }
    
    init(interactor: PokemonListInteractorProtocol) {
        self.interactor = interactor
    }
    
    private func fetchPokemonList(with url: String? = nil) {
        isLoading = true
        
        interactor.fetchPokemons() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonResult):
                    self.pokemonList += pokemonResult.results
                    self.nextURL = pokemonResult.next ?? ""
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.error = String(format: Constants.failedToFetchPokemonList, error.localizedDescription)
                }
            }
        }
    }
    
    func fetchPokemonList() {
        fetchPokemonList(with: nil)
    }
    
    func fetchNextPokemonList() {
        if !nextURL.isEmpty {
            fetchPokemonList(with: nextURL)
        }
    }
    
    func linkBuilder<Content: View>(for id: String, @ViewBuilder content: () -> Content) -> some View {
      NavigationLink (
        destination: router.makeDetailView(id: id)) {
            content()
      }
    }
}
