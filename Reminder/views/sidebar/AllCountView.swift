//
//  AllCountView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct AllCountView: View {
    
    let count: Int
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: Constants.Icons.trayCircleFill)
                    .font(.largeTitle)
                Text("All")
            } //: VStack
            Spacer()
            VStack {
                Text("\(self.count)")
                    .font(.title)
                EmptyView()
            } //: VStack
        } //: HStack
        .padding()
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    } //: body
}

#Preview {
    AllCountView(count: 5)
}
