//
//  LoginView.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var coordinator: AuthCoordinator
    @EnvironmentObject var userSession: UserSession
    @StateObject private var viewModel = UsuarioViewModel()
    @State private var email = ""
    @State private var password = ""
        
    var body: some View{
        ZStack{
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 28){
                
                Spacer()
                
                VStack(spacing: 12){
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height:60)
                        .foregroundColor(.white)
                    
                    Text("Property Pro")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Bem-vindo de volta!").font(.title)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                VStack(spacing: 16){
                    
                    TextField("Email", text: $email)
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
                            do {
                                try await viewModel.login(email: email, password: password)
                                if let user = viewModel.loggedUser{
                                    userSession.userId = user.id
                                    userSession.userName = user.nome
                                    userSession.email = user.email
                                }
                            } catch {
                                print("❌ Erro no login:", error.localizedDescription)
                            }
                        }
                    } label: {
                        Text("Entrar")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }

                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    Button{
                        coordinator.showRegister()
                    }label:{
                        Text("Não tem uma conta? ")
                            .foregroundColor(.secondary)
                        Text("Cadastre-se")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
    }
    
}

#Preview {
    let coordinator = AuthCoordinator()
    coordinator.currentView = .login
    return coordinator.currentScreen()
}
