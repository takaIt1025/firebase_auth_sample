//
//  Example2.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/02/25.
//

import Foundation
import SwiftUI

struct Example2: View {
    @State private var selectedTabIndex = 0

    @State private var tabs = ["Tab 1", "Tab 2", "Tab 3", "Tab 4"]

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // 上部のタブ
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(tabs.indices) { index in
                            Text(tabs[index])
                                .font(.system(size: 35))
                                .foregroundColor(selectedTabIndex == index ? .blue : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        tabs.rotate(by: index)
//                                        selectedTabIndex = index > 0 ? index - 1 : tabs.count - 1
                                        selectedTabIndex = index
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, geometry.safeAreaInsets.leading)
                    .padding(.top, geometry.safeAreaInsets.top)
                    .padding(.bottom, 8)
                }
                .frame(height: 14 + geometry.safeAreaInsets.top)
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
                            .frame(width: geometry.size.width)
                        }
                    }
                    .offset(x: -CGFloat(selectedTabIndex) * geometry.size.width)
                }
                .frame(height: geometry.size.height - 44 - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom)
                .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
        }
    }
}




struct Example2_Previews: PreviewProvider {
    static var previews: some View {
        Example2()
    }
}
