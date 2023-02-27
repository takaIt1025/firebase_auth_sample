//
//  example.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/02/25.
//

import Foundation
import SwiftUI
struct ScrollableTabView: View {
    @State private var selectedTabIndex = 0

    private let tabs = ["Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5", "Tab 6", "Tab 7", "Tab 8", "Tab 10"]

    var body: some View {
        VStack(spacing: 0) {
            // 上部のタブ
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(tabs.indices) { index in
                        Text(tabs[index])
                            .font(.system(size: 14))
                            .foregroundColor(selectedTabIndex == index ? .blue : .gray)
                            .onTapGesture {
                                withAnimation {
                                    selectedTabIndex = index
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 44)
            .border(Color.gray.opacity(0.5), width: 1)

            // 選択されたタブに対応するビュー
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(tabs.indices) { index in
                        VStack(spacing: 16) {
                            Text(tabs[index])
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                            Text("Content for \(tabs[index])")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .content.offset(x: CGFloat(Double(tabs.count - 1)/2 - Double(selectedTabIndex))  * UIScreen.main.bounds.width)
            .frame(height: UIScreen.main.bounds.height - 44)
        }
    }
}


struct Example_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableTabView()
    }
}
