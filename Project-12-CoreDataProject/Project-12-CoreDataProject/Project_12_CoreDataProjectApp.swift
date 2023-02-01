//
//  Project_12_CoreDataProjectApp.swift
//  Project-12-CoreDataProject
//
//  Created by Luca Capriati on 2022/09/12.
//

import SwiftUI

@main
struct Project_12_CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
