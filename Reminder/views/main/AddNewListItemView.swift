//
//  AddNewListItemView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct AddNewListItemView: View {
    
    @State private var title = ""
    @State private var dueDate: DueDate?
    
    var onSave: (String, Date?) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, content: {
                Image(systemName: Constants.Icons.circle)
                    .font(.system(size: 14))
                    .opacity(0.2)
                TextField("", text: self.$title)
            }) //: HStack
            Text("Notes")
                .opacity(0.2)
                .padding(.leading, 30)
            HStack {
                
                DueDateSelectionView(dueDate: self.$dueDate)
                
                if self.dueDate != nil {
                    Button("Clear") {
                        self.dueDate = nil
                    }
                }
                
                Button("Save") {
                    guard !self.title.isEmpty else { return }
                    self.onSave(self.title, self.dueDate?.value)
                    self.title = ""
                    self.dueDate = nil 
                }
                
            } //: HStack
            .padding()
        } //: VStack
    } //: body
}

#Preview {
    AddNewListItemView { _, _ in }
}
