//
//  AuthenticationRepository.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/12.
//

import Foundation
import FirebaseAuth

protocol AuthenticationRepository {
 
    func signUp(email: String, password: String, name: String) async throws-> (String?, AuthErrorCode.Code?)
    
    func login() -> Void
}

class AuthenticationRepositoryImpl : AuthenticationRepository{
    
    func login() {
    }
    
    
    func signUp(email: String, password: String, name: String) async throws -> (String?, AuthErrorCode.Code?){
        return try await AuthenticationControllerAPI().signUp(email: email, password: password, name: name)
    }
}
