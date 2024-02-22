//
//  ElementRowView.swift
//  PokemonList
//
//  Created by Evgeny on 20.02.24.
//

import SwiftUI

struct ElementRowView: View {
    let element: String
    var color: Color {
        switch element {
        case "grass": return Color.green
        case "poison": return Color.purple
        case "fire": return Color.red
        case "flying": return Color.blue
        case "water": return Color.blue
        case "bug": return Color.green
        case "normal": return Color.gray
        case "electric": return Color.yellow
        case "ground": return Color(red: 0.87, green: 0.72, blue: 0.53)
        case "fairy": return Color(red: 1.0, green: 0.75, blue: 0.79)
        case "rock": return Color(red: 0.69, green: 0.63, blue: 0.52)
        case "ice": return Color.blue
        case "dark": return Color(red: 0.4, green: 0.31, blue: 0.31)
        case "ghost": return Color(red: 0.31, green: 0.31, blue: 0.57)
        case "fighting": return Color(red: 0.75, green: 0.31, blue: 0.19)
        case "steel": return Color(red: 0.72, green: 0.72, blue: 0.81)
        case "dragon": return Color(red: 0.44, green: 0.22, blue: 0.85)
        case "psychic": return Color(red: 0.96, green: 0.35, blue: 0.6)
        default: return Color.gray
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(width: 100, height: 40)
                .cornerRadius(15)
            Text(element.capitalized)
                .bold()
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ElementRowView(element: "grass")
}
