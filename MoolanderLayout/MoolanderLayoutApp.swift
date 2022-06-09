//
//  MoolanderLayoutApp.swift
//  MoolanderLayout
//
//  Created by Данил Войдилов on 24.08.2021.
//

import SwiftUI

@main
struct MoolanderLayoutApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
					ContentView(layer: 1)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
