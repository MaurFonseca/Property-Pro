//
//  UserSession.swift
//  Property Pro
//
//  Created by Maurício Fonseca on 05/01/26.
//

import Foundation
import SwiftUI
import Combine

final class UserSession: ObservableObject{
    
    @Published var userId: String?
    @Published var userName: String = ""
    @Published var email: String = ""
    
    var isLoggedIn: Bool{
        userId != nil
    }
    
    func clear(){
        userId = nil
        userName = ""
        email = ""
    }
}
