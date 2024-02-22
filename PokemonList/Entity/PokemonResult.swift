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
struct Species: Codable, Hashable {
    let name: String

    // Implementing Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: Species, rhs: Species) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String?


    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable, Hashable {
    let slot: Int
    let type: Species
    
    // Implementing Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(slot)
            hasher.combine(type)
        }

        static func == (lhs: TypeElement, rhs: TypeElement) -> Bool {
            return lhs.slot == rhs.slot && lhs.type == rhs.type
        }
}
