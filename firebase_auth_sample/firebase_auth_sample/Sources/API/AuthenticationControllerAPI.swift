//
//  AuthenticationControllerAPI.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/12.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct AuthenticationControllerAPI {
    
    let auth = Auth.auth()
//    var userSession: Fire
    
    func login(email: String, password: String, name: String) -> AuthenticationResult? {
            var authResult: AuthenticationResult? = nil
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user else {
                print("##登録エラー##")
                authResult = AuthenticationResult.ValueError
                return
            }
            let request = user.createProfileChangeRequest()
            request.displayName = name
            request.commitChanges { error in
                if error == nil {
                    print("##登録完了")
                    authResult = AuthenticationResult.Success
                } else {
                    // TODO: 登録未完了の時、エラーを画面に表示
                    print("##登録エラー##コミットエラー")
                    authResult = AuthenticationResult.RegistrationError
                }
            }
        }
        return authResult
    }
    
    func signUp(email: String, password: String, name: String) async throws-> (String?, AuthErrorCode.Code?) {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)

            let uid = result.user.uid
            return (uid, nil)
        } catch {
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            return (nil, errorCode.self)
        }
    }
}

public enum AuthError: Error {
    // ネットワークエラー
    case networkError
    // パスワードが条件より脆弱であることを示します。
    case weakPassword
    // ユーザーが間違ったパスワードでログインしようとしたことを示します。
    case wrongPassword
    // ユーザーのアカウントが無効になっていることを示します。
    case userNotFound
    // メールアドレスの形式が正しくないことを示します。
    case invalidEmail
    // 既に登録されているメールアドレス
    case emailAlreadyInUse
    // 不明なエラー
    case unknown
    
    //エラーによって表示する文字を定義
    var title: String {
        switch self {
        case .networkError:
            return "通信エラーです。"
        case .weakPassword:
            return "パスワードが脆弱です。"
        case .wrongPassword:
            return "メールアドレス、もしくはパスワードが違います。"
        case .userNotFound:
            return "アカウントがありません。"
        case .invalidEmail:
            return "正しくないメールアドレスの形式です。"
        case .emailAlreadyInUse:
            return "既に登録されているメールアドレスです。"
        case .unknown:
            return "エラーが起きました。"
        }
    }
}
