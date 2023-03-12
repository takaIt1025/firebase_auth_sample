//
//  UserDataSource.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/13.
//


import FirebaseFirestore
import Combine

class UserDataSourceImpl {
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
    
    func updateUserInfo(uid: String, name: String, email: String, selfIntroduction: String?) async throws {
        var data: [String: Any] = [
            "name": name,
            "email": email
        ]
        if let selfIntroduction = selfIntroduction {
            data["selfIntroduction"] = selfIntroduction
        }
        try await userCollectionRef.document(uid).updateData(data)
    }
    
    func getUserInfo(uid: String) async throws -> User? {
        let snapshot = try await userCollectionRef.document(uid).getDocument()
        guard let data = snapshot.data() else {
            return nil
        }
        let user = User(data: data)
        return user
    }
}
