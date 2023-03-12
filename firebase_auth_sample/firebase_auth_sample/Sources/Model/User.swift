//
//  User.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/12.
//

import Foundation
import FirebaseAuth

class User: ObservableObject {
    let uid: String
    @Published var name: String?
    @Published var email: String?
    
    init(authData: FirebaseAuth.User) {
        // ユーザID
        self.uid = authData.uid
        // ユーザ名
        self.name = authData.displayName
        // メールアドレス
        self.email = authData.email
    }
}

