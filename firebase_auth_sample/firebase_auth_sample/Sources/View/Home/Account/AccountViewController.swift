//
//  AccountViewController.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/12.
//

import Foundation

import SwiftUI
import FirebaseCore

struct AccountViewController: View {
//    var viewModel = ContentViewModel()
//    @State var inputName: String = ""
//    @State var inputEmail: String = ""
    @State var selectTag = 1
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("マイページ")
            }
        }
    }
}

struct AccountViewController_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewController()
    }
}
