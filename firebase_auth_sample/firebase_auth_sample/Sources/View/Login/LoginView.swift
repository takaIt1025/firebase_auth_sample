//
//  LoginView.swift
//  Shared
//
//  Created by Takaya Ito on 2023/01/05.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {
    // ログイン時にグローバル情報を更新するため
    @EnvironmentObject var userInfo: UserInfo
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Fire Base auth").font(.system(size: 36, weight: .heavy))
                VStack(spacing: 24) {
                    TextField("名前", text: $viewModel.inputName).textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 280)
                    TextField("メールアドレス", text: $viewModel.inputEmail).textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 280)
                    SecureField("パスワード", text: $viewModel.inputPassword)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxWidth: 280)
                }
                .frame(height: 200)
                
                NavigationLink(destination: HomeViewController(),
                               tag: PageName.HomeView, selection: $viewModel.page) {
                }
                Button(action: {
                    Task {
                        print("##ユーザ登録処理")
                        await viewModel.pushSignUpButton()
                    }
                },
               label: {
                   Text("ユーザ登録")
                       .fontWeight(.medium)
                       .frame(minWidth: 160)
                       .foregroundColor(.white)
                       .padding(12)
                       .background(Color.accentColor)
                       .cornerRadius(8)
               })
                
                Button(action: {
                    Task {
                    print("##ユーザ登録処理")
                    await viewModel.pushLoginButton()
                    }
                },
               label: {
                   Text("ログイン")
                       .fontWeight(.medium)
                       .frame(minWidth: 160)
                       .foregroundColor(.white)
                       .padding(12)
                       .background(Color.accentColor)
                       .cornerRadius(8)
               })
            }
        }.alert(isPresented: $viewModel.isError){
            Alert(title: Text("エラー"), message: Text(LocalizedStringKey($viewModel.errorMessage.wrappedValue)), dismissButton: .default(Text("閉じる"), action: {}))
        }.environmentObject(viewModel.userInfo)
    }
}

