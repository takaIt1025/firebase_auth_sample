//
//  StorageRepository.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/15.
//

import Foundation
import FirebaseStorage

protocol StorageRepository {
    // 画像アップロード
    func uploadImage(imageData: Data, userId: String) async throws -> String
}


class StorageRepositoryImpl: StorageRepository{
    private let storage = Storage.storage()
    
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
}
