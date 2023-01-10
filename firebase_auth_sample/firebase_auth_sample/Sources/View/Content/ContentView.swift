//
//  ContentView.swift
//  Shared
//
//  Created by Takaya Ito on 2023/01/05.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    @State var inputName: String = ""
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    @State var page : Int? = 0
    @ObservedObject var viewModel = ContentViewModel()

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
                
                NavigationLink(destination: HomeViewController(),
                               tag: 1, selection: $viewModel.page) {
                }
                        Button(action: {
                       print("##ユーザ登録処理")
                            
                            
                        viewModel.pushButton(name: inputName, email: inputEmail, password: inputPassword)
                            page = viewModel.page
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
