//
//  Operador.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 02/01/26.
//

import Foundation
import FirebaseFirestore

struct Operador: Identifiable, Codable{
    
    @DocumentID var id: String?
    var nome: String
}
