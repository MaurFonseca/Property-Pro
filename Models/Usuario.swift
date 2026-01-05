//
//  Usuario.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 30/12/25.
//

import Foundation
import FirebaseFirestore

struct Usuario: Identifiable, Codable{
    
    @DocumentID var id: String?
    var email: String
    var nome: String
}
