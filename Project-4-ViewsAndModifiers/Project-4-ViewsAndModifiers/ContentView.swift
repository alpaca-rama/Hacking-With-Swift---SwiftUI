//
//  ContentView.swift
//  Project-4-ViewsAndModifiers
//
//  Created by Luca Capriati on 2022/08/22.
//
// Project 4 - Challange 3: Create a custom ViewModifier (and accompanying View extension) that makes a view
//  have a large, blue font suitable for prominent titles in a view.

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func title() -> some View {
        modifier(TitleModifier())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .title()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
