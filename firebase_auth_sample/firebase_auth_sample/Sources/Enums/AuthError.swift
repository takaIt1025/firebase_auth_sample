//
//  AuthError.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/12.
//

import Foundation

public enum AuthError: Error {
    
    // ログインエラー
    case signInFailed(error: String)
    // 登録エラー
    case signUpFailed(error: String)
    // 更新エラー
    case updateUserFailed(error: String)
    //エラーによって表示する文字を定義
    var title: String {
        switch self {
            
        case .signInFailed(error: let error):
            return error
        case .signUpFailed(error: let error):
            return error
        case .updateUserFailed(error: let error):
            return error
        }
    }
}
