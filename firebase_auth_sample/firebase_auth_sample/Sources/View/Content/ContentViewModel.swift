//
//  ContentViewModel.swift
//  firebase_auth_sample
//
//  Created by Takaya Ito on 2023/01/06.
//

import Foundation
import FirebaseAuth
import SwiftUI

class ContentViewModel :ObservableObject{
    @Published var inputName: String = ""
    @Published var inputEmail: String = ""
    @Published var inputPassword: String = ""
    @Published var page : Int? = 0
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func pushSignUpButton() async {
        Task {
            do {
                print("タスク開始")
                let result  = try await AuthenticationRepositoryImpl().signUp(email: self.inputEmail, password: self.inputPassword, name: self.inputName)
                if result.1 != nil {
                    return DispatchQueue.main.async {
                        print("errorです！！！！！！！！！！！！！")
                        self.isError = true
                        switch result.1 {
                                case .networkError:
                            self.errorMessage =  AuthError.networkError.title
                                case .weakPassword:
                            self.errorMessage =  AuthError.weakPassword.title
                                case .wrongPassword:
                            self.errorMessage =  AuthError.wrongPassword.title
                                case .userNotFound:
                            self.errorMessage =  AuthError.userNotFound.title
                                default:
                            self.errorMessage =  AuthError.unknown.title
                                }
                    }
                }
                return DispatchQueue.main.async {
                    self.page = 1
                }
            } catch {

                print("valueError")
                return 

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
