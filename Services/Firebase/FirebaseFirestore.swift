//
//  FirebaseFirestore.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import FirebaseFirestore

final class FirestoreService{
    let database = Firestore.firestore()
    
    func document<T: Codable> (in collection: String, id: String, as type: T.Type) async throws -> T{
        let snapshot = try await database.collection(collection).document(id).getDocument()
        
        return try snapshot.data(as: T.self)
    }
    
    func add<T: Codable> (_ data: T, to collection:String) async throws{
        try database.collection(collection).addDocument(from: data)
    }
    
    func update<T: Codable> (_ data: T, in collection:String, id:String) async throws{
        try database.collection(collection).document(id).setData(from: data, merge: true)
    }
    
    func delete(in collection: String, id: String) async throws{
        try await database.collection(collection).document(id).delete()
    }
}
