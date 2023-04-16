//
//  ItemsListViewModel.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/04/02.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import SwiftUI

// 画面更新
class ItemsListViewModel: ObservableObject {
    @Published var items: [Item] = []
    private let itemsRepository = ItemsRepositoryImpl()
    
    // 商品一覧を取得
    // TODO: エラ〜ハンドリングの考慮
    func fetchItems() async throws {
        do {
            let fetchedItems = try await itemsRepository.getItems()
            DispatchQueue.main.async {
                self.items = fetchedItems
            }
        } catch {
            throw error
        }
    }
}
