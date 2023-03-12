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
    @Published var inputName: String = ""
    @Published var inputEmail: String = ""
    @Published var inputPassword: String = ""
    @Published var page : PageName? = nil
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
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
                try await AuthenticationRepositoryImpl().signIn(email: self.inputEmail, password: self.inputPassword)
                
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
