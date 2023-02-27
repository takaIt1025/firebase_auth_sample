//
//  Example2.swift
//  firebase_auth_sample (iOS)
//
//  Created by Takaya Ito on 2023/02/25.
//

import Foundation
import SwiftUI

struct ScrollableTabView3: View {
    @State private var tabs = ["Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5", "Tab 6", "Tab 7", "Tab 8", "Tab 9"]

        var body: some View {
            VStack {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab)
                        .onTapGesture {
                            $tabs.wrappedValue.rotate(by: 1)
                        }
                }
            }
        }
    }

// 配列を回転させるためのコード
extension Array {
    mutating func rotate(by amount: Int) {
        guard count > 1, amount != 0 else { return }
        let sliceIndex = amount % count
        let slice = self[..<sliceIndex]
        self.removeSubrange(..<(sliceIndex))
        self.append(contentsOf: slice)
    }
}


struct Example3_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableTabView3()
    }
}
