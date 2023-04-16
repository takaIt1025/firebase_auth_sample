//
//  AccountViewController.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/12.
//

import Foundation

import SwiftUI
import FirebaseCore
import UniformTypeIdentifiers
import PhotosUI

struct AccountViewController: View {
    
    @EnvironmentObject var userInfo: UserInfo
    @ObservedObject var viewModel = AccountViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("マイページ")
            }
            
            // TODO: firebaseStorageとの通信
            VStack {
                if let image = viewModel.myImage {
                    Image(uiImage: image)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    
                } else if let url = URL(string: userInfo.photoURL ?? ""),
                   let imageData = try? Data(contentsOf: url),
                   let image = UIImage(data: imageData){
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("No Data")
                        .font(.headline)
                }
                
                Button(action: {
                    viewModel.isPhotoPickerVisible.toggle()
                }) {
                    Text("プロフィール画像を選択する")
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    Task {
                        if let image = viewModel.myImage {
                            if let imageData = image.jpegData(compressionQuality: 1.0) {
                                await viewModel.updateUserPhoto(imageData: imageData)
                            }
                        }
                    }
                }) {
                    Text("プロフィール画像を更新")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $viewModel.isPhotoPickerVisible) {
                    PhotoPicker(isPresented: $viewModel.isPhotoPickerVisible, selectedImage: $viewModel.myImage)
                }
            }
            
            
            VStack(spacing: 24) {
                TextField("名前", text: $viewModel.inputName).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 280)
                TextField("メールアドレス", text: $viewModel.inputEmail).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 280)
                TextField("紹介文", text: $viewModel.inputIntroudction).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 280)
                SecureField("パスワード", text: $viewModel.inputPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(maxWidth: 280)
            }
            
            Button(action: {
                Task {
                    await viewModel.pushUpdateButton()
                }
            },
           label: {
               Text("更新")
                   .fontWeight(.medium)
                   .frame(minWidth: 160)
                   .foregroundColor(.white)
                   .padding(12)
                   .background(Color.accentColor)
                   .cornerRadius(8)
           })
            
        }
        .onAppear{
            // Viewが初めて表示される際に実行されるメソッド
            viewModel.inputName = userInfo.name
            viewModel.inputEmail = userInfo.email
            viewModel.inputIntroudction = userInfo.selfIntroduction ?? ""
            print("####AccountView onAppear")
            print("Name: \(userInfo.name)")
            print("Email: \(userInfo.email)")
        }
    }
}

struct AccountViewController_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewController()
    }
}
