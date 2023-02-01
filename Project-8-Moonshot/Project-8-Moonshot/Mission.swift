//
//  Mission.swift
//  Project-8-Moonshot
//
//  Created by Luca Capriati on 2022/08/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    // variable names to access the appolo mission number from the missions.json file
    var displayName: String {
        "Apollo \(id)"
    }
    
    // variable name to access the apollo mission images which are stored in the assets catelog
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
