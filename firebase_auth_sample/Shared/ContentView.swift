//
//  ContentView.swift
//  Shared
//
//  Created by Takaya Ito on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Fire Base auth").font(.system(size: 36, weight: .heavy))
                VStack(spacing: 24) {
                    TextField("メールアドレス", text: $inputEmail).textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 280)
                    SecureField("パスワード", text: $inputPassword)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxWidth: 280)
                }
                .frame(height: 200)
                Button(action: {
                   print("Login処理")
                },
               label: {
                   Text("Login")
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
