//
//  AuthCoordinator.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//
import Combine
import SwiftUI

final class AuthCoordinator: ObservableObject{
    @Published var currentView: AuthFlow = .login
    @Published var isAuthenticated = false

    
    enum AuthFlow{
        case login
        case register
    }
    
    func showRegister(){
        currentView = .register
    }
    
    func showLogin(){
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
