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
    @ObservedObject var viewModel = AccountViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("マイページ")
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
            

            // TODO: レイアウトの調整
            // TODO: firebaseStorageとの通信
            VStack {
                if let image = viewModel.importedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("No image imported")
                        .font(.headline)
                }

                Button(action: {
                    viewModel.isPhotoPickerVisible.toggle()
                }) {
                    Text("Import Image from Camera Roll")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
                .sheet(isPresented: $viewModel.isPhotoPickerVisible) {
                    PhotoPicker(isPresented: $viewModel.isPhotoPickerVisible, selectedImage: $viewModel.importedImage)
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
    }
}

struct AccountViewController_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewController()
    }
}
