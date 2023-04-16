//
//  ItemDetailViewController.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/04/07.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

// TODO: 画面のレイアウト修正
struct ItemDetailViewController: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ItemDetailViewModel
    var body: some View {
        VStack{
            if let url = URL(string: viewModel.item.imageURL ),
               let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData){
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
            }
            Text("商品詳細画面")
            Text("タイトル：\(viewModel.item.title)")
            Text("金額：\(viewModel.item.price)")
            Text("商品説明：\(viewModel.item.description)")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.backward")
                Text("戻る")
            }
        }
    }

    var logoutButton: some View {
        Button(action: {
            // ログアウト処理をここに記述してください
        }) {
            Text("ログアウト")
        }
    }
}
