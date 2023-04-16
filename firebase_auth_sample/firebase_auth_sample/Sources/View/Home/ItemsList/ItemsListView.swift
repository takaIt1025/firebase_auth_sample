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
        ScrollView {
                    VStack(alignment: .center, spacing: 20){
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
                            ForEach(viewModel.items) { item in
                                if let url = URL(string: item.imageURL) {
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
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            Task {
                do {
                    viewModel.items = try await viewModel.fetchItems()
                    print("####tetchItems:\(viewModel.items.count)")
                    print("###1: \(viewModel.items[0].imageURL)")
                    print("###2: \(viewModel.items[1].imageURL)")
                    
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
