//
//  Activities.swift
//  Milestone-4-Habit-Tracker
//
//  Created by Luca Capriati on 2022/08/30.
//

import Foundation

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: saved) {
                activities = decoded
                
                return
            }
        }
        
        // if things have failed, create it empty.
        activities = []
    }
}
