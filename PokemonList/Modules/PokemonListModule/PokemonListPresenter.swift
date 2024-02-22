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
    private var previousURL: String = ""
    @Published var error: String = ""
    @Published var isLoading: Bool = true
    
    @Published var pokemonList: [Results] = []
    
    
    init(interactor: PokemonListInteractorProtocol) {
        self.interactor = interactor
    }
    
    private func fetchPokemonList(with url: String? = nil) {
        isLoading = true
        
        interactor.fetchPokemons(url: url) { result in
            switch result {
            case .success(let pokemonResult):
                self.pokemonList = pokemonResult.results
                self.nextURL = pokemonResult.next ?? ""
                self.previousURL = pokemonResult.previous ?? ""
                self.isLoading = false
            case .failure(let error):
                self.error = "Failed to fetch pokemon list: \(error.localizedDescription)"
                print("Failed to fetch pokemon list: \(error.localizedDescription)")
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
    
    func fetchPreviousPokemonList() {
        if !previousURL.isEmpty {
            fetchPokemonList(with: previousURL)
        }
    }
    
    func linkBuilder<Content: View>(for url: String, @ViewBuilder content: () -> Content) -> some View {
      NavigationLink (
        destination: router.makeDetailView(url: url)) {
            content()
      }
    }
}
