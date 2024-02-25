//
//  PokemonListView.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var presenter: PokemonListPresenter
    
    enum Constants {
        static let loadingData = NSLocalizedString("loading_data", comment: "")
        static let pokemonListTitle = NSLocalizedString("pokemon_list", comment: "")
        static let previousButtonTitle = NSLocalizedString("previous", comment: "")
        static let nextButtonTitle = NSLocalizedString("next", comment: "")
    }
    
    var body: some View {
        NavigationView {
            if presenter.isLoading && presenter.pokemonList.isEmpty {
                loadingView
            } else if !presenter.error.isEmpty {
                Text(presenter.error)
                    .foregroundStyle(Color("text"))
                    .lineLimit(0)
            } else {
                pokemonListView
            }
        }
        .onAppear {
            presenter.fetchPokemonList()
        }
    }
    
    var loadingView: some View {
        VStack {
            ProgressView()
            Text(Constants.loadingData)
                .foregroundStyle(Color("text"))
        }
    }
    
    var pokemonListView: some View {
        VStack {
            List {
                ForEach (presenter.pokemonList) { pokemon in
                    self.presenter.linkBuilder(for: pokemon.id) {
                        PokemonRowView(pokemon: pokemon)
                    }
                    .onAppear {
                        if self.presenter.pokemonList.last == pokemon {
                            presenter.fetchNextPokemonList()
                        }
                    }
                }
            }
            .navigationTitle(Constants.pokemonListTitle)
            .listStyle(PlainListStyle())
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = PokemonListInteractor(service: PokemonListService(dataService: DataService(caching: NSCacheDataCaching(), fetching: URLSessionDataFetching())))
        let presenter = PokemonListPresenter(interactor: interactor)
        PokemonListView(presenter: presenter)
    }
}
