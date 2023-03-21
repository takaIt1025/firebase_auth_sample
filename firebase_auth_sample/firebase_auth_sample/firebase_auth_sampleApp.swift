//
//  firebase_auth_sampleApp.swift
//  Shared
//
//  Created by Takaya Ito on 2023/01/05.
//

import SwiftUI
import FirebaseCore

@main
class firebase_auth_sampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // 全画面で利用するユーザ情報
    var userInfo = UserInfo(data: [:])
    required init() {
        // 初期化処理
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(userInfo)
        }
    }
    
}
