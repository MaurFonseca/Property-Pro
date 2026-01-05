//
//  AuthCoordinator.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//
import Combine
import SwiftUI

import FirebaseAuth

final class AuthCoordinator: ObservableObject {

    @Published var currentView: AuthFlow = .login
    @Published var isAuthenticated = false

    private var listener: AuthStateDidChangeListenerHandle?

    init() {
        listener = Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = (user != nil)
        }
    }

    deinit {
        if let listener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }

    enum AuthFlow {
        case login
        case register
    }

    func showRegister() {
        currentView = .register
    }

    func showLogin() {
        currentView = .login
    }

    @ViewBuilder
    func currentScreen() -> some View {
        switch currentView {
        case .login:
            LoginView(coordinator: self)
        case .register:
            RegisterView(coordinator: self)
        }
    }
}
