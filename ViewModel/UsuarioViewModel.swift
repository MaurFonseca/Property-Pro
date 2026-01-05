import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class UsuarioViewModel: ObservableObject {
    
    @Published var authUser: FirebaseAuth.User?
    @Published var usuario: Usuario?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var loggedUser: Usuario?
    
    private let authService = AuthService()
    private let usuarioRepository = UsuarioRepository()
    
    func register(email: String, password: String, name: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.register(
                email: email,
                password: password,
                nome: name
            )
            try Auth.auth().signOut()
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func login(email: String, password: String) async throws {
            // Auth Firebase (exemplo)
            let result = try await Auth.auth().signIn(withEmail: email, password: password)

            // Buscar dados do usuário no Firestore
            let snapshot = try await Firestore.firestore()
                .collection("usuarios")
                .document(result.user.uid)
                .getDocument()

            self.loggedUser = try snapshot.data(as: Usuario.self)
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
