//
//  FirebaseManager.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import FirebaseCore

final class FirebaseManager{
    static let shared = FirebaseManager()
    
    private init() {
        FirebaseApp.configure()
    }
}
