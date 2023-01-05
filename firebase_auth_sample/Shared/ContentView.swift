//
//  ContentView.swift
//  Shared
//
//  Created by Takaya Ito on 2023/01/05.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    var viewModel = ContentViewModel()
    @State var inputName: String = ""
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Fire Base auth").font(.system(size: 36, weight: .heavy))
                VStack(spacing: 24) {
                    TextField("名前", text: $inputName).textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 280)
                    TextField("メールアドレス", text: $inputEmail).textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 280)
                    SecureField("パスワード", text: $inputPassword)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxWidth: 280)
                }
                .frame(height: 200)
                Button(action: {
                   print("##ユーザ登録処理")
                    viewModel.pushButton(name: inputName, email: inputEmail, password: inputPassword)
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
