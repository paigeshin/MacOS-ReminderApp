//
//  MyListViewModel.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation
import CoreData
import SwiftUI

struct MyListViewModel: Identifiable {
    
    private let myList: MyList
    
    init(myList: MyList) {
        self.myList = myList
    }
    
    var id: NSManagedObjectID { self.myList.objectID }
    var name: String { self.myList.name ?? "" }
    var color: Color { Color(self.myList.color ?? .clear) }
    var itemsCount: Int { self.items.count }
    var items: [MyListItemViewModel] {
        guard
            let items = self.myList.items,
            let myItems = (items.allObjects as? [MyListItem])
        else { return [] }
        return myItems.filter { !$0.isCompleted }.map(MyListItemViewModel.init)
    }
}
