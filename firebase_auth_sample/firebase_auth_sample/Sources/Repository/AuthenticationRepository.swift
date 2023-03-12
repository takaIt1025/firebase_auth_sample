//
//  AuthenticationRepository.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/12.
//

import Foundation
import FirebaseAuth

protocol AuthenticationRepository {
    // 新規登録
    func signUp(email: String, password: String, name: String) async throws-> String
    // ログイン
    func signIn(email: String, password: String) async throws -> String
    // ログアウト
    func signOut() throws
}

class AuthenticationRepositoryImpl : AuthenticationRepository{
    func signOut() throws {
        // TODO: 今後実装
    }
    
    func signIn(email: String, password: String) async throws -> String{
        do {
           return  try await FirebaseAuthDataSourceImpl().signIn(email: email, password: password)
        } catch {
            throw error
        }
    }
    
    func signUp(email: String, password: String, name: String) async throws -> String{
        
        do {
            return try await FirebaseAuthDataSourceImpl().signUp(email: email, password: password, name: name)
        } catch let error as NSError {
            throw error
        }
    }
}
