//
//  UsuarioRepository.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import FirebaseFirestore

final class UsuarioRepository{
    
    private let collection = Firestore.firestore().collection("usuarios")
    
    func saveUser(_ user: Usuario)async throws{
        print("📦 Salvando usuário:", user)
        try collection.document(user.id ?? UUID().uuidString).setData(from: user, merge: true)
    }
    
    func fetchUser(by id: String) async throws -> Usuario?{
        let document = try await collection.document(id).getDocument()
        return try document.data(as: Usuario.self)
    }
    
    func fetchAllUsers() async throws -> [Usuario]{
        let snapshot = try await collection.getDocuments()
        return snapshot.documents.compactMap{
            try? $0.data(as: Usuario.self)
        }
    }
    
    func deleteUser(by id: String) async throws{
        try await collection.document(id).delete()
    }
}
