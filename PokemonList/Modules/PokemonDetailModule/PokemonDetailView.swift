//
//  PokemonDetailView.swift
//  PokemonList
//
//  Created by Evgeny on 17.02.24.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var presenter: PokemonDetailPresenter
    
    var body: some View {
        ScrollView {
            if presenter.isLoading {
                loadingView
            } else if presenter.error != "" {
                Text(presenter.error)
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
    
    var loadingView: some View {
        VStack {
            ProgressView()
            Text("Loading Data from Server")
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
                            .foregroundColor(.gray)
                        ProgressView()
                    }
                }
                .frame(width: 350, height: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(Color.black, lineWidth: 2)
                )
            } else {
                Image("Not Found")
                    .resizable()
                    .frame(width: 350, height: 250)
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
                pokemonStatsView(stat: "Height", value: "\(pokemon.height * 100) cm")
                     
                pokemonStatsView(stat: "Weight", value: "\(pokemon.weight) kg")
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
    
    
    struct PokemonDetailtView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonDetailView(presenter: PokemonDetailPresenter(interactor: PokemonDetailInteractor(service: PokemonDetailService(dataService: DataService(caching: NSCacheDataCaching(), fetching: URLSessionDataFetching())), urlData: "https://pokeapi.co/api/v2/pokemon/-1/")))
        }
    }

