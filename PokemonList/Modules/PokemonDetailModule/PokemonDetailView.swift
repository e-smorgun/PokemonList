//
//  PokemonDetailView.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var presenter: PokemonDetailPresenter
    
    enum Constants {
        static let loadingData = NSLocalizedString("loading_data", comment: "")
        static let notFound = NSLocalizedString("not_found", comment: "")
        static let height = NSLocalizedString("height", comment: "")
        static let weight = NSLocalizedString("weight", comment: "")
    }
    
    var body: some View {
        ScrollView {
            if presenter.isLoading {
                loadingView
            } else if !presenter.error.isEmpty {
                errorView
            } else {
                VStack(alignment: .center) {
                    pokemonImageView
                    if let pokemon = presenter.pokemon {
                        pokemonInfoView(pokemon: pokemon)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .onAppear {
            presenter.fetchPokemonData()
        }
    }
    
    var errorView: some View {
        VStack {
            if presenter.error == "Failed to fetch pokemon list: The operation couldn’t be completed. (No internet connection error 0.)" {
                    Text("No internet connection and cached data")

            } else if presenter.error == "Failed to fetch pokemon list: The data couldn’t be read because it is missing." {
                Text("No data was found for this Pokemon.")
            } else {
                Text(presenter.error)
                    .lineLimit(0)
                    .frame(alignment: .center)
            }
            Button {
                presenter.fetchPokemonData()
            } label: {
                Text("Try again")
            }
        }
    }
    
    var loadingView: some View {
        VStack {
            ProgressView()
            Text(Constants.loadingData)
        }
    }
    
    var pokemonImageView: some View {
        Group {
            if let imageUrl = presenter.pokemon?.sprites.frontDefault {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("background"))
                            .cornerRadius(35)
                        ProgressView()
                    }
                }
                .frame(width: 350, height: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(Color.primary, lineWidth: 2)
                )
            } else {
                Image(Constants.notFound)
                    .resizable()
                    .frame(width: 350, height: 250)
                    .cornerRadius(35)
            }
        }
    }
    
    func pokemonInfoView(pokemon: PokemonResult) -> some View {
        VStack(alignment: .leading) {
            Text(pokemon.name.capitalized)
                .font(.system(size: 36))
                .bold()
                
            Text("№ \(String(pokemon.id))")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
                .bold()
                .padding(.bottom, 20)
            
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(pokemon.types, id: \.self) { element in
                        ElementRowView(element: element.type.name)
                    }
                }
            }.padding(.bottom, 20)
            
            Divider()
            
            HStack(alignment: .center, spacing: 40) {
                Spacer()
                pokemonStatsView(stat: Constants.height, value: "\(pokemon.height * 100) cm")
                     
                pokemonStatsView(stat: Constants.weight, value: "\(pokemon.weight) kg")
                Spacer()

            }
        }
    }
    
    func pokemonStatsView(stat: String, value: String) -> some View {
        VStack {
            Text(stat)
                .font(.system(size: 24))
            
            Text(value)
                .bold()
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
}
    
    
    struct PokemonDetailView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonDetailView(presenter: PokemonDetailPresenter(interactor: PokemonDetailInteractor(service: PokemonDetailService(dataService: DataService(caching: NSCacheDataCaching(), fetching: URLSessionDataFetching())), id: "1")))
        }
    }
