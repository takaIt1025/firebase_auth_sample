//
//  HomeViewModel.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/03/18.
//

import Foundation

class HomeViewModel :ObservableObject{
    @Published var selectTag:PageName = PageName.HomeView
    @Published var itemsListVM = ItemsListViewModel()
    @Published var acountVM = AccountViewModel()
}
