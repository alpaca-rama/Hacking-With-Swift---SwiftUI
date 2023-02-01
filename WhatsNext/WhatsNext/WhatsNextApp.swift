//
//  WhatsNextApp.swift
//  WhatsNext
//
//  Created by Luca Capriati on 2022/08/21.
//

import SwiftUI

@main
struct WhatsNextApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
