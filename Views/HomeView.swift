//
//  HomeView.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 05/01/26.
//

import SwiftUI
import FirebaseAuth


struct HomeView: View {
    
    // MARK: - Coordinator
    // @ObservedObject var coordinator: AppCoordinator
    // Exemplo futuro:
    // @ObservedObject var coordinator: HomeCoordinator
    
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        ZStack {
            // Fundo padrão do app
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 28) {
                
                // Header
                HStack {
                    VStack(spacing: 8) {
                        Image(systemName: "house.and.flag.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        
                        Text("Olá \(userSession.userName)👋")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                        Text("Property Pro")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Painel de Controle")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }

                    Spacer()

                    Button {
                        do {
                            try Auth.auth().signOut()
                        } catch {
                            print("❌ Erro ao fazer logout:", error.localizedDescription)
                        }
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Sair")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)

                
                // Card principal
                VStack(spacing: 16) {
                    
                    HomeButton(
                        title: "Operadores",
                        icon: "person.badge.plus"
                    ) {
                        // coordinator.showCreateOperator()
                    }
                    
                    HomeButton(
                        title: "Casas",
                        icon: "house.fill"
                    ) {
                        // coordinator.showCreateProperty()
                    }
                    
                    HomeButton(
                        title: "Cadastrar nova Work Order",
                        icon: "wrench.and.screwdriver"
                    ) {
                        // coordinator.showCreateWorkOrder()
                    }
                    
                    HomeButton(
                        title: "Lista de Work Orders",
                        icon: "list.bullet.rectangle"
                    ) {
                        // coordinator.showWorkOrdersList()
                    }
                    
                    HomeButton(
                        title: "Gráficos",
                        icon: "chart.bar.xaxis"
                    ) {
                        // coordinator.showCharts()
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

struct HomeButton: View {
    
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}


#Preview {
    let session = UserSession()
    session.userName = "Maurício"
    
    return HomeView()
        .environmentObject(session)
}
