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
            let service = PokemonListService(dataService: DataService(cacheManager: CacheManager(), fetching: URLSessionDataFetching()))
            let interactor = PokemonListInteractor(service: service)
            let presenter = PokemonListPresenter(interactor: interactor)
            PokemonListView(presenter: presenter)
        }
    }
}
