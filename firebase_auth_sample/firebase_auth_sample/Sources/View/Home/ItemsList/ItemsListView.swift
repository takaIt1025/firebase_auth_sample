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
    
    
    @ObservedObject var viewModel = ItemsListViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20){
                ForEach(viewModel.items) { item in
                    if let url = URL(string: viewModel.items.first?.imageURL ?? "" ),
                       let imageData = try? Data(contentsOf: url),
                       let image = UIImage(data: imageData){
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
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
