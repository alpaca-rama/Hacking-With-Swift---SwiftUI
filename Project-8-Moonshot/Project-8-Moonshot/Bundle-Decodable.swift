//
//  Bundle-Decodable.swift
//  Project-8-Moonshot
//
//  Created by Luca Capriati on 2022/08/24.
//

import Foundation

// This file is created to decode the JSON file into the loaded variable, with error handling for the file not found, being able to decode or load.
extension Bundle {
    // <T> is a placedholder. A Generic.
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in dundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
