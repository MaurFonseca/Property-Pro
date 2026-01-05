//
//  AppCoordinator.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import SwiftUI

struct AppCoordinator: View {
    
    @StateObject private var authCoordinator = AuthCoordinator()
    @StateObject private var userSession = UserSession()
    
    var body: some View {
        switch authCoordinator.isAuthenticated {
        case true:
            HomeView()
                .environmentObject(userSession)
        case false:
            authCoordinator.currentScreen()
                .environmentObject(userSession)
        }
    }
}
