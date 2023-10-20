//
//  MylistItemsView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct MyListItemsView: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            List(1...10, id: \.self) { index in
                Text("Item \(index)")
            } //: List
        }) //: VStack 
    } //: body
}

#Preview {
    MyListItemsView()
}
