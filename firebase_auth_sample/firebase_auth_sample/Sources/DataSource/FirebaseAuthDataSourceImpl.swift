//
//  AuthenticationControllerAPI.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/12.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase


protocol FirebaseAuthDataSource {
    // ログイン
    func signIn(email: String, password: String) async throws -> User
    // 新規登録
    func signUp(email: String, password: String, name: String) async throws -> User
    // ログアウト
    func signOut() throws
    // 現在利用しているユーザ情報
    var currentUser: User? { get }
}

struct FirebaseAuthDataSourceImpl:FirebaseAuthDataSource {
    
    var currentUser: User?
    
    
    let auth = Auth.auth()
    
    func signIn(email: String, password: String) async throws -> User {
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            return User(authData: authResult.user)
        } catch let error as NSError {
            

            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            switch errorCode {
                case .networkError:
                    throw AuthError.signInFailed(error: "firebase_signInFailed")
                case .weakPassword:
                    throw AuthError.signInFailed(error: "firebase_signInFailed")
                case .wrongPassword:
                    throw AuthError.signInFailed(error: "firebase_wrongPassword")
                case .userNotFound:
                    throw AuthError.signInFailed(error: "firebase_userNotFound")
                default:
                    throw AuthError.signInFailed(error: "firebase_unknown")
                }
        }
    }

    func signUp(email: String, password: String, name: String) async throws-> User {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            var user = User(authData: result.user)
            user.name = name
            // メールアドレスとパスワードを利用して登録を完了させた後に、更新実行する必要あり
            try await updateUser(user)
            return user
        } catch let error as NSError {
            //TODO: エラーの細かな分岐は今後追記、一旦ベタ書き。
            throw AuthError.signUpFailed(error: "登録できませんでした")
        }
    }
    
    private func updateUser(_ user: User) async throws {
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = user.name
        do {
            try await changeRequest?.commitChanges()
        } catch let error as NSError {
            //TODO: エラーの細かな分岐は今後追記、一旦ベタ書き。
            throw AuthError.updateUserFailed(error: "更新できませんでした")
        }
    }
    
    func signOut() throws {
        // TODO: ログアウト処理は今後実装
    }
}
