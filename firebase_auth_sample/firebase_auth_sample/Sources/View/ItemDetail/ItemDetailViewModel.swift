//
//  ItemDetailViewModel.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/04/07.
//

import Foundation

class ItemDetailViewModel :ObservableObject{
    @Published var item: Item
    
    init(item: Item) {
        self.item = item
    }
}
