//
//  PokemonRowView.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import SwiftUI

struct PokemonRowView: View {
    let pokemon: Results
    
    var body: some View {
        VStack {
            Text(pokemon.name.capitalized)
                .padding(.vertical, 5)
                .foregroundColor(Color("text"))
                .multilineTextAlignment(.center)
                .font(.system(size: 24))
        }
    }
}

struct PokemonListView_Previews1: PreviewProvider {
    static var previews: some View {
        let interactor = PokemonListInteractor(service: PokemonListService(dataService: DataService(cacheManager: CacheManager(), fetching: URLSessionDataFetching())))
        let presenter = PokemonListPresenter(interactor: interactor)
        PokemonListView(presenter: presenter)
    }
}
