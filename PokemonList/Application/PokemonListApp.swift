//
//  PokemonListApp.swift
//  PokemonList
//
//  Created by Evgeny on 16.02.24.
//

import SwiftUI

@main
struct PokemonListApp: App {
    var body: some Scene {
        WindowGroup {
            let interactor = PokemonListInteractor()
            let presenter = PokemonListPresenter(interactor: interactor)
            PokemonListView(presenter: presenter)
        }
    }
}
