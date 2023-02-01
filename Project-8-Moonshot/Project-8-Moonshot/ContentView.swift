//
//  ContentView.swift
//  Project-8-Moonshot
//
//  Created by Luca Capriati on 2022/08/24.
//
// Project 8 - Challange 1: Add the launch date to MissionView, below the mission badge. You might choose to format this differently
//  given that more space is available, but it’s down to you.
// Project 8 - Challange 2: Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in
//  MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.
// Project 8 - Challange 3: For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid
//  and as a list.
// Project 8 - Bonus Challange: Having the app remember which view type the user preffered

import SwiftUI

struct ContentView: View {
    // Project 8 - Bonus Challange
    @AppStorage("showingGrid") private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    if showingGrid {
                        Label("Show as table", systemImage: "list.dash")
                    } else {
                        Label("Show as grid", systemImage: "square.grid.2x2")
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
