//
//  MyListsView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct MyListsView: View {
    
    @StateObject private var vm: MyListsViewModel
    
    init(vm: MyListsViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                AllCountView(count: self.vm.allListItemesCount)
                Text("My Lists")
                ForEach(self.vm.myLists) { myList in
                    
                    NavigationLink {
                        MyListItemsHeaderView(
                            name: myList.name,
                            count: myList.itemsCount,
                            color: myList.color
                        )
                        MyListItemsView(
                            items: myList.items,
                            onItemAdded: { title, dueDate in
                                self.vm.saveTo(
                                    list: myList,
                                    title: title,
                                    dueDate: dueDate
                                )
                            }, 
                            onItemDeleted: { item in
                                self.vm.deleteItem(item)
                            },
                            onItemCompleted: { item in
                                self.vm.markAsCompleted(item)
                            })
                    } label: {
                        HStack {
                            let systemName = Constants.Icons.line3HorizontalCircleFill
                            Image(systemName: systemName)
                                .font(.title)
                                .foregroundStyle(myList.color)
                            Text(myList.name)
                            Spacer()
                            Text("\(myList.itemsCount)")
                        } //: HStack
                    } //: NavigationLink
                    .contextMenu(ContextMenu(menuItems: {
                        Button {
                            self.vm.delete(myList)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }))
                } //: ForEach
            } //: List
        } //: VStack
    }
}

#Preview {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    return MyListsView(vm: MyListsViewModel(context: context))
}
