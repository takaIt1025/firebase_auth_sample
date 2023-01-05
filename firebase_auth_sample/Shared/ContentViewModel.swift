//
//  ContentViewModel.swift
//  firebase_auth_sample
//
//  Created by Takaya Ito on 2023/01/06.
//

import Foundation
import FirebaseAuth

class ContentViewModel {
    func pushButton(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let request = user.createProfileChangeRequest()
                request.displayName = name
                request.commitChanges { error in
                    if error == nil {
                        print("##登録実施")
                    } else {
                        print("##登録未完了")
                    }
                }
            }
        }
    }
}
