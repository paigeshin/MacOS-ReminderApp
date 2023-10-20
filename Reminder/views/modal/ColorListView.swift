//
//  ColorListView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct ColorListView: View {
    
    private let colors: [Color] = [.red, .orange, .green, .blue, .purple]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            
            ForEach(self.colors, id: \.self) { color in
                let systemName = self.selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill
                Image(systemName: systemName)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture(perform: {
                        self.selectedColor = color
                    })
                
            } //: ForEach
            
        } //: HStack
    }
}

#Preview {
    ColorListView(selectedColor: .constant(.blue))
}
