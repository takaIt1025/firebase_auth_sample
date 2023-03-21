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
    @Published var uid: String
    // ユーザー名
    @Published var name: String
    // メールアドレス
    @Published var email: String
    // 写真
    @Published var photoURL: String?
    // 紹介文
    @Published var selfIntroduction: String?
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.photoURL = data["photoURL"] as? String
        self.selfIntroduction = data["selfIntroduction"] as? String
    }
    
    func saveUserInfo(data: UserInfo?)  {
        guard let data = data else { return }
        self.uid = data.uid
        self.name = data.name
        self.email = data.email
        self.photoURL = data.photoURL
        self.selfIntroduction = data.selfIntroduction
    }
}

