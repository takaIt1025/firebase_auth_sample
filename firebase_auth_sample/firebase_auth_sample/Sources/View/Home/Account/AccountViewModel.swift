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
    
    
    func pushUpdateButton() async {
        Task { () -> Void in
            do {
                guard let uid = AuthenticationRepositoryImpl().getCurrentUser()?.uid else {return}
                try await UserRepositoryImpl().updateUserInfo(uid: uid, name: self.inputName, email: self.inputEmail, selfIntroduction: self.inputIntroudction)
                
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
