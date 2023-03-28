//
//  StorageRepository.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/15.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

protocol StorageRepository {
    // 画像アップロード
    func uploadImage(imageData: Data, userId: String) async throws -> String
    
    // 画像の取得
    func downloadImage(userId: String, completion: @escaping (UIImage?) -> Void)
    
    func getImageURL(uid: String) async throws -> URL
}


class StorageRepositoryImpl: StorageRepository{
    private let storage = Storage.storage()
    let db = Firestore.firestore()
    
    func uploadImage(imageData: Data, userId: String) async throws -> String {
        let storageRef = storage.reference()
        let imageRef = storageRef.child("users/\(userId)/profile.jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let task = imageRef.putData(imageData, metadata: metadata)
        _ = try await task.snapshot
        let url = try await imageRef.downloadURL()
        return url.absoluteString
    }
    
    func downloadImage(userId: String, completion: @escaping (UIImage?) -> Void) {
            let storageRef = storage.reference()
            let imageRef = storageRef.child("users/\(userId)/profile.jpg")
            
            imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    completion(nil)
                } else if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }
    func getImageURL(uid: String) async throws -> URL {
//        guard let currentUser = Auth.auth().currentUser else {
//            throw NSError(domain: "MyApp", code: 400, userInfo: [NSLocalizedDescriptionKey: "User not found"])
//        }

        let userRef = db.collection("users").document(uid)

        do {
            let document = try await userRef.getDocument()
            guard let data = document.data(), let urlString = data["imageUrl"] as? String, let url = URL(string: urlString) else {
                throw NSError(domain: "MyApp", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid image URL"])
            }
            return url
        } catch {
            throw error
        }
    }
}
