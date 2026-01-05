//
//  FirebaseStorage.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import FirebaseStorage
import SwiftUI

final class StorageService{
    private let storage = Storage.storage()
    
    func upload(data: Data, path: String)async throws -> URL{
        let ref = storage.reference().child(path)
        _ = try await ref.putDataAsync(data)
        return try await ref.downloadURL()
    }
    
    func downloadData(from url: URL) async throws -> Data{
        let ref = storage.reference(forURL: url.absoluteString)
        let data = try await ref.data(maxSize: 5 * 1024 * 1024)
        return data
    }
    
    func delete(path: String) async throws{
        try await storage.reference().child(path).delete()
    }
}
