//
//  PokemonResult.swift
//  PokemonList
//
//  Created by Evgeny on 16.02.24.
//

import Foundation

// MARK: - PokemonResult
struct PokemonResult: Codable {
    let baseExperience: Int
    let forms: [Species]
    let height: Int
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case forms
        case height
        case id
        case name
        case sprites, types, weight
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    var allSprites: [String] {
           var sprites: [String] = []
           if let backDefault = backDefault {
               sprites.append("backDefault " + backDefault)
           }
           if let backFemale = backFemale {
               sprites.append("backFemale " + backFemale)
           }
           if let backShiny = backShiny {
               sprites.append(backShiny)
           }
           if let backShinyFemale = backShinyFemale {
               sprites.append(backShinyFemale)
           }
           if let frontDefault = frontDefault {
               sprites.append(frontDefault)
           }
           if let frontFemale = frontFemale {
               sprites.append(frontFemale)
           }
           if let frontShiny = frontShiny {
               sprites.append(frontShiny)
           }
           if let frontShinyFemale = frontShinyFemale {
               sprites.append(frontShinyFemale)
           }

        return sprites
       }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
