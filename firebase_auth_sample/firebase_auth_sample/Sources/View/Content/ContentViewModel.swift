//
//  ContentViewModel.swift
//  firebase_auth_sample
//
//  Created by Takaya Ito on 2023/01/06.
//

import Foundation
import FirebaseAuth

class ContentViewModel :ObservableObject{
    @Published var page : Int? = 0
    func pushButton(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user else {
                print("##登録エラー##")
                return
            }
            let request = user.createProfileChangeRequest()
            request.displayName = name
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
}
