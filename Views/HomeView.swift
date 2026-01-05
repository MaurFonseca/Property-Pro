//
//  HomeView.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 05/01/26.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Coordinator
    //@ObservedObject var coordinator: AppCoordinator
    // Exemplo futuro:
    // @ObservedObject var coordinator: HomeCoordinator
    
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
                VStack(spacing: 8) {
                    Image(systemName: "house.and.flag.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                    
                    Text("Property Pro")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Painel de Controle")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                // Card principal
                VStack(spacing: 16) {
                    
                    HomeButton(
                        title: "Cadastrar novo Operador",
                        icon: "person.badge.plus"
                    ) {
                        // coordinator.showCreateOperator()
                    }
                    
                    HomeButton(
                        title: "Cadastrar nova Casa",
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
    HomeView()
}
