//
//  ItemsListView.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/11.
//

import Foundation
import SwiftUI
import FirebaseCore
import UniformTypeIdentifiers
import PhotosUI

struct ItemsListView: View {
//    var viewModel = ContentViewModel()
//    @State var inputName: String = ""
//    @State var inputEmail: String = ""
    @State var selectTag = 1
    let width = UIScreen.main.bounds.width / 3 - 5;
    
    @ObservedObject var viewModel = ItemsListViewModel()
    var body: some View {
        NavigationView {
                    ScrollView {
                        VStack(alignment: .center, spacing: 20){
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
                                ForEach(viewModel.items) { item in
                                    if let url = URL(string: item.imageURL) {
                                        NavigationLink(destination: ItemDetailViewController(viewModel: ItemDetailViewModel(item: item))) {
                                            AsyncImage(url: url) { phase in
                                                switch phase {
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: width, height: width)
                                                        .clipped()
                                                case .failure, .empty:
                                                    Color.gray
                                                        .frame(width: width, height: width)
                                                default:
                                                    ProgressView()
                                                        .frame(width: width, height: width)
                                                }
                                            }
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                    }
                }
        .onAppear{
            Task {
                try await viewModel.fetchItems()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("updateImages"))) { _ in
                Task {
                    try await viewModel.fetchItems()
                }
            }
        
        .refreshable {
            Task {
                do {
                    print("###itemsListView プルリフレッシュ")
                    try await viewModel.fetchItems()
                } catch {
                    print("updateUserPhoto(imageData: Data) でエラー")
                    
                }
            }
        }
    }
}


struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
