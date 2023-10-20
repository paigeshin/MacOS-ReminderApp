//
//  EditListItemViewModel.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation

final class EditListItemViewModel: ObservableObject {
    
    var listItemVM: MyListItemViewModel
    
    @Published var title = ""
    @Published var selectedDate: Date?
    
    init(listItemVM: MyListItemViewModel) {
        self.listItemVM = listItemVM
        self.title = listItemVM.title
        self.selectedDate = listItemVM.dueDate?.value
    }
    
    func save() {
        guard let myListItem: MyListItem = MyListItem.byId(id: self.listItemVM.listItemID) else { return }
        myListItem.title = self.title
        myListItem.dueDate = self.selectedDate
        try? myListItem.save()
    }
    
}
