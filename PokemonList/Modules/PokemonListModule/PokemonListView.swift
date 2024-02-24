//
//  PokemonListView.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var presenter: PokemonListPresenter
    
    var body: some View {
        NavigationView {
            if presenter.isLoading {
                loadingView
            } else if presenter.error != "" {
                Text(presenter.error)
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
            Text(NSLocalizedString("loading_data", comment: ""))
        }
    }
    
    var pokemonListView: some View {
        VStack {
            List {
                ForEach (presenter.pokemonList) { pokemon in
                    self.presenter.linkBuilder(for: pokemon.id) {
                        PokemonRowView(pokemon: pokemon)
                    }
                }
            }
            .navigationTitle(NSLocalizedString("pokemon_list", comment: ""))
            .listStyle(PlainListStyle())
            
            pagingView
        }
    }
    
    var pagingView: some View {
        HStack {
            Button(action: {
                presenter.fetchPreviousPokemonList()
            }) {
                Text(NSLocalizedString("previous", comment: ""))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .disabled(false)
            
            Spacer()
            
            Button(action: {
                presenter.fetchNextPokemonList()
            }) {
                Text(NSLocalizedString("next", comment: ""))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .disabled(false)
        }
        .padding()
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = PokemonListInteractor(service: PokemonListService(dataService: DataService(caching: NSCacheDataCaching(), fetching: URLSessionDataFetching())))
        let presenter = PokemonListPresenter(interactor: interactor)
        PokemonListView(presenter: presenter)
    }
}
