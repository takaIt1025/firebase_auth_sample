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
    @State var selectTag = 1
    var body: some View {
        TabView(selection: $selectTag) {
            ItemsListView().tabItem{
                Text("tab1")
            }.tag(PageName.ItemsListView)
            AccountViewController().tabItem{Text("tab2")}.tag(PageName.AccountView)
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
