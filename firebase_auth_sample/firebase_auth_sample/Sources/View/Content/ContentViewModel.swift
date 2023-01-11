//
//  ContentViewModel.swift
//  firebase_auth_sample
//
//  Created by Takaya Ito on 2023/01/06.
//

import Foundation
import FirebaseAuth

class ContentViewModel :ObservableObject{
    @Published var inputName: String = ""
    @Published var inputEmail: String = ""
    @Published var inputPassword: String = ""
    @Published var page : Int? = 0
    
    func pushSignUpButton() {
        Auth.auth().createUser(withEmail: self.inputEmail, password: self.inputPassword) { result, error in
            guard let user = result?.user else {
                print("##登録エラー##")
                return
            }
            let request = user.createProfileChangeRequest()
            request.displayName = self.inputName
            request.commitChanges { error in
                if error == nil {
                    print("##登録完了")
                    self.page = 1
                } else {
                    // TODO: 登録未完了の時、エラーを画面に表示
                    print("##登録エラー##コミットエラー")
                }
            }
        }
    }
    func pushLoginButton() {
        Auth.auth().signIn(withEmail: self.inputEmail, password: self.inputPassword) { result, error in
            if result?.user != nil {
                // ログイン成功処理
                print("##ログイン成功")
                self.page = 1
            } else {
                print("##ログインエラー")
            }
        }
    }
}
