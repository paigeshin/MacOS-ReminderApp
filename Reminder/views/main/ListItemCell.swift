//
//  ListItemCell.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct ListItemCell: View {
    
    @State private var active = false
    @State private var showPopOver = false
    @State private var checked = false
    
    let item: MyListItemViewModel
    
    var onListItemDeleted: (MyListItemViewModel) -> Void = { _ in }
    var onListItemCompleted: (MyListItemViewModel) -> Void = { _ in }
    
    private let delay = Delay()
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            let systemName = self.checked ? Constants.Icons.circleInsetFilled : Constants.Icons.circle
            Image(systemName: systemName)
                .font(.system(size: 14))
                .opacity(0.2)
                .onTapGesture {
                    self.checked.toggle()
                    if self.checked {
                        self.delay.performWork {
                            self.onListItemCompleted(self.item)
                        }
                    } else {
                        self.delay.cancel()
                    }
                }
            
            VStack(alignment: .leading) {
                Text(self.item.title)
                if let dueDate = self.item.dueDate {
                    Text(dueDate.title)
                        .opacity(0.4)
                        .foregroundStyle(dueDate.isPastDue ? .red : .primary)
                }
            } //: VStack
            
            Spacer()
            
            if self.active {
                Image(systemName: "multiply.circle")
                    .foregroundStyle(.red)
                    .onTapGesture {
                        self.onListItemDeleted(self.item)
                    }
                Image(systemName: Constants.Icons.exclaimationMarkCircle)
                    .foregroundStyle(.purple)
                    .onTapGesture {
                        self.showPopOver.toggle()
                    }
                    .popover(isPresented: self.$showPopOver, arrowEdge: .leading, content: {
                        EditListItemView(
                            item: self.item,
                            onUpdated: {
                                self.showPopOver = false 
                            }
                        )
                    })
            }
            
        } //: HStack
        .contentShape(Rectangle())
        .onHover(perform: { hovering in
            if !self.showPopOver { self.active = hovering }
        })
    } //: body
} //: ListItemCell

#Preview {
    ListItemCell(item: MyListItemViewModel(myListItem: MyListItem()))
}
