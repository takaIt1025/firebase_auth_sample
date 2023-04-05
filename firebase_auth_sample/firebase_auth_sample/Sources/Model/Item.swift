//
//  Item.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/04/02.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Item: Identifiable, Codable {
    var id: String?
    var title: String
    var description: String
    var price: Int
    var imageURL: String
    // TODO: Itemに含むフィールドはどこかで検討する
//    var category_id: String
//    var condition_id: Int
//    var shipping_fee_payer_id: Int
//    var shipping_origin_area_id: Int
//    var shipping_days_id: Int
//    var item_image: String
//    var status_id: Int
//    var created_at: Timestamp
//    var updated_at: Timestamp
    init(title: String, description: String, price: Int, imageURL: String) {
        self.title = title
        self.description = description
        self.price = price
        self.imageURL = imageURL
    }
}
