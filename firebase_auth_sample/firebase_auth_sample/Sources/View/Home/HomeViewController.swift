//
//  HomeViewController.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/06.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct HomeViewController: View {
//    var viewModel = ContentViewModel()
//    @State var inputName: String = ""
//    @State var inputEmail: String = ""
    @ObservedObject var viewModel  = HomeViewModel()
    var body: some View {
        TabView(selection: $viewModel.selectTag) {
            ItemsListView().tabItem{
                Text("tab_home_name")
            }.tag(PageName.ItemsListView)
            AccountViewController().tabItem{Text("tab_mypage_name")}.tag(PageName.AccountView)
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
