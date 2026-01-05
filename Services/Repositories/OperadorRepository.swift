//
//  OperadorRepository.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 02/01/26.
//

import FirebaseFirestore

final class OperadorRepository{
    
    private let collection = Firestore.firestore().collection("operadores")
    
    func addOperador(_ operador: Operador, completion: @escaping(Result<Void, Error>)-> Void){
        do{
            _ = try collection.addDocument(from:operador)
            completion(.success(()))
        }catch{
            completion(.failure(error))
        }
    }
    
    func findByNome(by nome: String)async throws -> [Operador]{
        
        guard !nome.isEmpty else {
            let snpashot = try await collection.getDocuments()
            return snpashot.documents.compactMap{doc in
                var operador = try? doc.data(as:Operador.self)
                operador?.id = doc.documentID
                return operador
            }
        }
        
        let end = nome + "\u{f8ff}"
        
        let snpashot = try await collection
            .order(by: "nome")
            .start(at: [nome])
            .end(at: [end])
            .getDocuments()
        
        return snpashot.documents.compactMap{ doc in
            var operador = try? doc.data(as: Operador.self)
            operador?.id = doc.documentID
            return operador
        }
    }
    
    func fetchOperadores(completion: @escaping(Result<[Operador], Error>)-> Void){
        collection.getDocuments{ snapshot, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            let operadores = snapshot?.documents.compactMap{
                try? $0.data(as: Operador.self)
            } ?? []
            
            completion(.success(operadores))
        }
    }
    
    func updateOperador(_ operador: Operador, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let id = operador.id else { return }

            do {
                try collection.document(id).setData(from: operador)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }

    func deleteOperador(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        collection.document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

}
