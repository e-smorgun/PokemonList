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
            if presenter.isLoading == true {
                loadingView
            } else {
                VStack {
                    
                    AsyncImage(url: URL(string: presenter.pokemon?.sprites.frontDefault ?? "LoadData")) { image in
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
                    
                    Text("Base Exp: \(presenter.pokemon!.baseExperience)")

                    
                    if let height = presenter.pokemon?.height {
                        Text("Height: \(String(height))")
                    } else {
                        Text("Height Not Found")
                    }
                    if let weight = presenter.pokemon?.weight {
                        Text("Weight: \(String(weight))")
                    } else {
                        Text("Weight Not Found")
                    }
                    
                    
                }
                .navigationBarTitle(Text(presenter.pokemon!.name.capitalized), displayMode: .inline)
            }
        }.onAppear {
            presenter.fetchPokemonData()
        }
    }
    
    var loadingView: some View {
        VStack {
            ProgressView()
            Text("Loading Data from Server")
        }
    }
}

struct PokemonDetailtView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(presenter: PokemonDetailPresenter(interactor: PokemonDetailInteractor(UrlData: "https://pokeapi.co/api/v2/pokemon/1/")))
    }
}
