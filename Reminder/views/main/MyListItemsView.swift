//
//  MylistItemsView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct MyListItemsView: View {
    
    var items: [MyListItemViewModel]
    
    typealias ItemAdded = ((String, Date?) -> Void)?
    typealias ItemDeleted = ((MyListItemViewModel) -> Void)?
    
    var onItemAdded: ItemAdded
    var onItemDeleted: ItemDeleted
    
    init(
        items: [MyListItemViewModel],
        onItemAdded: ItemAdded = nil,
        onItemDeleted: ItemDeleted = nil
    ) {
        self.items = items
        self.onItemAdded = onItemAdded
        self.onItemDeleted = onItemDeleted
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            
            List {
                
                ForEach(self.items, id: \.listItemID) { item in
                    ListItemCell(item: item, onListItemDeleted: { item in
                        self.onItemDeleted?(item)
                    })
                } //: ForEach
                
                AddNewListItemView { title, dueDate in
                    self.onItemAdded?(title, dueDate)
                }
                
            } //: List

        }) //: VStack
    } //: body
}

#Preview {
    MyListItemsView(items: [])
}
