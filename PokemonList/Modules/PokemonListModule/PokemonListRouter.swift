//
//  PokemonListRouter.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import Foundation
import UIKit
import SwiftUI

class PokemonListRouter {
    func makeDetailView(id: String) -> some View {
        let service = PokemonDetailService(dataService: DataService(cacheManager: CacheManager(), fetching: URLSessionDataFetching()))
        let interactor = PokemonDetailInteractor(service: service, id: id)
        let presenter = PokemonDetailPresenter(interactor: interactor)
        
        return PokemonDetailView(presenter: presenter)
    }
}
