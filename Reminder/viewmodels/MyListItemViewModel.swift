//
//  MyListItemViewModel.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation
import CoreData

struct MyListItemViewModel: Identifiable {
    
    private let myListItem: MyListItem
    let id = UUID()
    
    init(myListItem: MyListItem) {
        self.myListItem = myListItem
    }
    
    var listItemID: NSManagedObjectID { self.myListItem.objectID }
    var title: String { self.myListItem.title ?? "" }
    var dueDate: DueDate? {
        if let date = self.myListItem.dueDate {
            return DueDate.from(value: date)
        }
        return nil
    }
    var isCompleted: Bool { self.myListItem.isCompleted }
    
}
