//
//  User.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/12.
//

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {
    // ユーザーID
    let uid: String
    // ユーザー名
    let name: String
    // メールアドレス
    let email: String
    // 写真
    let photoURL: String?
    // 紹介文
    let selfIntroduction: String?
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.photoURL = data["photoURL"] as? String
        self.selfIntroduction = data["selfIntroduction"] as? String
    }
}

