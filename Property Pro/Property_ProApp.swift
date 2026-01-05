//
//  Property_ProApp.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import SwiftUI
import FirebaseCore

@main
struct Property_ProApp: App {
    
    init() {
            print("🎯 Bundle:", Bundle.main.bundleIdentifier ?? "nil")
            FirebaseApp.configure()
            print("🔥 Firebase configurado:", FirebaseApp.app() != nil)
        }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
        }
    }
}
