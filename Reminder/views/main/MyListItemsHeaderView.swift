//
//  MyListHeaderView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct MyListItemsHeaderView: View {
    
    let name: String
    let count: Int
    let color: Color
    
    var body: some View {
        HStack {
            Text(self.name)
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundStyle(self.color)
                .padding()
            
            Spacer()
            
            Text("\(self.count)")
                .font(.system(size: 32))
                .foregroundStyle(self.color)
                .padding()
        } //: HStack
    }
}

#Preview {
    MyListItemsHeaderView(name: "Hello", count: 5, color: .green)
}
