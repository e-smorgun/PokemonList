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
    func makeDetailView(url: String) -> some View {
        let service = PokemonDetailService(dataService: DataService(caching: NSCacheDataCaching(), fetching: URLSessionDataFetching()))
        let interactor = PokemonDetailInteractor(service: service, urlData: url)
        let presenter = PokemonDetailPresenter(interactor: interactor)
        
        return PokemonDetailView(presenter: presenter)
    }
}
