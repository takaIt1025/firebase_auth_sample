//
//  ItemsRepository.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/04/02.
//

import Foundation
import FirebaseFirestore

protocol itemsRepository {
    // TODO: めんどくさいんでRepositoryで通信しちゃっているが、dataSouce層に処理を移行させたい
    // 商品の一覧取得
    func getItems() async throws -> [Item]
    // TODO: 商品のアップロード
    // TODO: 商品の編集
    // TODO: 商品の削除
    
}

class ItemsRepositoryImpl: itemsRepository{
    private var db = Firestore.firestore()
    private let itemsCollectionRef = Firestore.firestore().collection("items")
    
    // 商品の一覧取得
    func getItems() async throws -> [Item]{
        // 一覧の格納先
        var items: [Item] = []
        let snapshot = try await itemsCollectionRef.getDocuments()
        for document in snapshot.documents {
            // TODO: if letで弾くだけにしている商品に含めるものは検討
            if let item = try? document.data(as: Item.self) {
                items.append(item)
            }
        }
        return items
    }

}
