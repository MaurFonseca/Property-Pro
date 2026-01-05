//
//  RegisterView.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var coordinator: AuthCoordinator
    @StateObject private var viewModel = UsuarioViewModel()
    
    @State private var nome = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 28) {
                
                Spacer()
                
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "person.badge.plus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                    
                    Text("Criar Conta")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Preencha os dados para continuar")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                // Card de Cadastro
                VStack(spacing: 16) {
                    
                    TextField("Nome completo", text: $nome)
                        .textInputAutocapitalization(.words)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    SecureField("Senha", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Button {
                        Task {
                            await viewModel.register(
                                email: email,
                                password: password,
                                name: nome
                            )
                            coordinator.showLogin()
                        }
                    } label: {
                        Text("Registrar")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal)
                
                Spacer()
                
                // Voltar para Login
                Button {
                    coordinator.showLogin()
                } label: {
                    HStack(spacing: 4) {
                        Text("Já tem uma conta?")
                            .foregroundColor(.secondary)
                        
                        Text("Entrar")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    let preview = AuthCoordinator()
    preview.currentView = .register
    return preview.currentScreen()
}
