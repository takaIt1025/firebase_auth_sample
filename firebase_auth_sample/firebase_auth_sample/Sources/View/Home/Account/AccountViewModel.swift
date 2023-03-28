//
//  AccountViewModel.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/13.
//

import Foundation
import FirebaseAuth
import SwiftUI

class AccountViewModel :ObservableObject{
    @Published var inputName: String = ""
    @Published var inputEmail: String = ""
    @Published var inputPassword: String = ""
    @Published var inputIntroudction: String = ""
    @Published var page : PageName? = nil
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isPhotoPickerVisible: Bool = false
    @Published var downloadedImage: UIImage?
    
    // 認証機能のRepository
    private let authRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
    // ユーザー情報のRepository
    private let userRepository: UserRepository = UserRepositoryImpl()
    // 画像関連のRepository
    private let storageRepository: StorageRepository = StorageRepositoryImpl()
    
    func downloadPhoto() {
        guard let uid = authRepository.getCurrentUser()?.uid else {return}
        storageRepository.downloadImage(userId: uid) { image in
            self.downloadedImage = image
        }
    }
    
    func updateUserPhoto(imageData: Data) async {
        Task { () -> Void in
            do {
                // ユーザーIDを取得
                guard let uid = authRepository.getCurrentUser()?.uid else {return}
                // Storageに対してイメージをアップロードし、保存先のURLを取得
                let imageUrl = try await storageRepository.uploadImage(imageData: imageData, userId: uid)
                // 画像をURLをユーザ情報に保存
                try await userRepository.updateUserInfo(uid: uid, photoURL: imageUrl)
            } catch {
            // TODO: エラー処理を追加
                print("updateUserPhoto(imageData: Data) でエラー")
            }
        }
    }
    
    func pushUpdateButton() async {
        Task { () -> Void in
            do {
                // ログインユーザーの情報を取得
                guard let uid = authRepository.getCurrentUser()?.uid else {return}
                
                // TODO: phtoURL一旦空にしているので、調整が必要
                try await userRepository.updateUserInfo(uid: uid, name: self.inputName, email: self.inputEmail, photoURL:"", selfIntroduction: self.inputIntroudction)
                
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
