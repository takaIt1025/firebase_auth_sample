//
//  LoginViewModel.swift
//  firebase_auth_sample
//
//  Created by Takaya Ito on 2023/01/06.
//

import Foundation
import FirebaseAuth
import SwiftUI

class LoginViewModel :ObservableObject{
    // ログイン時に取得したデータを一時保存するための変数
    @Published var userInfo: UserInfo = UserInfo(data: [:])
    @Published var inputName: String = ""
    @Published var inputEmail: String = ""
    @Published var inputPassword: String = ""
    @Published var page : PageName? = nil
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var downloadedImage: UIImage?
    
    // 認証機能のRepository
    private let authRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
    // ユーザー情報のRepository
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    // 画像関連のRepository
     private let storageRepository: StorageRepository = StorageRepositoryImpl()
     
    func getImageURL() {
        
    }
    
     func downloadPhoto() {
         guard let uid = authRepository.getCurrentUser()?.uid else {return}
         storageRepository.downloadImage(userId: uid) { image in
             self.downloadedImage = image
         }
     }
    
    func pushSignUpButton() async {
        Task { () -> Void in
            do {
                let userId  = try await AuthenticationRepositoryImpl().signUp(email: self.inputEmail, password: self.inputPassword, name: self.inputName)
                
                try await UserRepositoryImpl().saveUserInfo(uid: userId, name: self.inputName , email: self.inputEmail, selfIntroduction: nil)
                
                return DispatchQueue.main.async {
                    self.page = PageName.HomeView
                }
            } catch let error as AuthError {
                DispatchQueue.main.async {
                    self.errorMessage = error.title
                    self.isError = true
                }
            } catch {
                errorMessage = error.localizedDescription
                self.isError = true
            }
        }
    }
    
    func pushLoginButton() async {
        Task { () -> Void in
            do {
                // メールアドレスとパスワードからユーザーIDを取得
                let uid = try await AuthenticationRepositoryImpl().signIn(email: self.inputEmail, password: self.inputPassword)
                // ユーザーIDからユーザー情報を取得
                let u = try await userRepository.getUserInfo(uid: uid)
                self.userInfo.saveUserInfo(data: u)
                
                return DispatchQueue.main.async {
                    self.page = PageName.HomeView
                }
            } catch let error as AuthError {
                DispatchQueue.main.async {
                    self.errorMessage = error.title
                    self.isError = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                }
            }
        }
    }
}
