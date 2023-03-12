//
//  FireStoreRepository.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/12.
//

import FirebaseFirestore
import Combine
protocol UserRepository {
    // ユーザー情報登録
    func saveUserInfo(uid: String, name: String?, email: String?, selfIntroduction: String?) async throws
    // ユーザー情報更新
    func updateUserInfo(uid: String, name: String?, email: String?, selfIntroduction: String?) async throws
    // ユーザー情報取得
//    func getUserInfo(uid: String) async throws -> User?
}

class UserRepositoryImpl: UserRepository {
        private let db = Firestore.firestore()
        private let userCollectionRef = Firestore.firestore().collection("users")
        
    func saveUserInfo(uid: String, name: String?, email: String?, selfIntroduction: String?) async throws
    {
        do{
            try await UserDataSourceImpl().saveUserInfo(uid: uid, name: name, email: email, selfIntroduction: selfIntroduction)
        } catch {
            throw error
        }
    }
    
    func updateUserInfo(uid: String, name: String?, email: String?, selfIntroduction: String?) async throws {
        do{
            try await UserDataSourceImpl().updateUserInfo(uid: uid, name: name, email: email, selfIntroduction: selfIntroduction)
        } catch {
            throw error
        }
    }
    
    func getUserInfo(uid: String) async throws -> UserInfo? {
        let snapshot = try await userCollectionRef.document(uid).getDocument()
        guard let data = snapshot.data() else {
            return nil
        }
        let user = UserInfo(data: data)
        return user
    }
}
