//
//  Astronaut.swift
//  Project-8-Moonshot
//
//  Created by Luca Capriati on 2022/08/24.
//

import Foundation

// Codable - Allows us to make instances of this, straight from JSON.
// Indetifiable - Allows the use of arrays, disctionaries inside of SwiftUI in dynamic loops, etc
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
