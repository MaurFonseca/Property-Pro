import SwiftUI
import Combine
import FirebaseAuth

@MainActor
final class UsuarioViewModel: ObservableObject {
    
    @Published var authUser: FirebaseAuth.User?
    @Published var usuario: Usuario?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authService = AuthService()
    private let usuarioRepository = UsuarioRepository()
    
    func register(email: String, password: String, name: String) async {
        print("🟡 ViewModel.register iniciado")
        isLoading = true
        errorMessage = nil
        
        do {
            print("🔐 Chamando AuthService.register")
            try await authService.register(
                email: email,
                password: password,
                nome: name
            )
            
            authUser = authService.currentUser()
            print("👤 Auth user:", authUser?.uid ?? "nil")
            usuario = try await fetchCurrentUser()
            print("📦 Usuario carregado do Firestore:", usuario ?? "nil")
            
        } catch {
            print("🔥 ERRO AO REGISTRAR:", error)
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        print("✅ ViewModel.register finalizado")
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            authUser = try await authService.singIn(
                email: email,
                password: password
            )
            
            usuario = try await fetchCurrentUser()
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func logout() {
        do {
            try authService.singOut()
            authUser = nil
            usuario = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchCurrentUser() async throws -> Usuario? {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        return try await usuarioRepository.fetchUser(by: uid)
    }
}
