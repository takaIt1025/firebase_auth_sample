//
//  ItemsListView.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/01/11.
//


import SwiftUI
import FirebaseCore

struct ItemsListView: View {
//    var viewModel = ContentViewModel()
//    @State var inputName: String = ""
//    @State var inputEmail: String = ""
    @State var selectTag = 1
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("一覧")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing:3) {
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                }
                HStack(spacing:3) {
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                }
                HStack(spacing:3) {
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                }
                HStack(spacing:3) {
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                }
                HStack(spacing:3) {
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
                    Image("タープ").resizable(resizingMode: .stretch).aspectRatio(contentMode: .fit)
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
