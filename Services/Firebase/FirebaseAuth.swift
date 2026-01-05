//
//  FirebaseAuth.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import FirebaseAuth

protocol AuthServiceProtocol{
    func singIn(email: String, password: String) async throws -> User
    func singOut()throws
    func currentUser() -> FirebaseAuth.User?
}

final class AuthService: AuthServiceProtocol{
    
    private let usuarioRepository = UsuarioRepository()
    
    func singIn(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    func singOut() throws {
        try Auth.auth().signOut()
    }
    func currentUser() -> FirebaseAuth.User? {
        Auth.auth().currentUser
    }
    
    func register(email:String, password:String, nome:String) async throws{
        print("🟠 AuthService.register iniciado")
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = result.user.uid
        print("🆔 Usuário criado no Auth:", uid)
        
        let user = Usuario(id: uid, email: email, nome: nome)
        print("💾 Salvando usuário no Firestore:", user)
        try await usuarioRepository.saveUser(user)
        print("✅ Usuário salvo no Firestore")
    }
}
