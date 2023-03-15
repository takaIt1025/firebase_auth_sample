//
//  UserDataSource.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/13.
//


import FirebaseFirestore
import Combine

protocol UserDataSource {
    func saveUserInfo(uid: String, name: String?, email: String?, selfIntroduction: String?) async throws
    func updateUserInfo(uid: String, name: String?, email: String?,photoURL:String?, selfIntroduction: String?) async throws
    func getUserInfo(uid: String) async throws -> UserInfo?
}

class UserDataSourceImpl: UserDataSource {
    private let db = Firestore.firestore()
    private let userCollectionRef = Firestore.firestore().collection("users")
    
    func saveUserInfo(uid: String, name: String?, email: String?, selfIntroduction: String?) async throws {
        var data: [String: Any] = [
            "uid": uid,
            "name": name ?? "nil",
            "email": email ?? "email"
        ]
        if let selfIntroduction = selfIntroduction {
            data["selfIntroduction"] = selfIntroduction
        }
        try await userCollectionRef.document(uid).setData(data)
    }
    
    func updateUserInfo(uid: String, name: String?, email: String?, photoURL:String?, selfIntroduction: String?) async throws {
        var data: [String: Any] = [:]
        if let name = name, name != "" {
            data["name"] = name
        }
        if let email = email, email != "" {
            data["email"] = email
        }
        if let selfIntroduction = selfIntroduction, selfIntroduction != "" {
            data["selfIntroduction"] = selfIntroduction
        }
        if let photoURL = photoURL, photoURL != "" {
            data["photoURL"] = photoURL
        }
        try await userCollectionRef.document(uid).updateData(data)
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
