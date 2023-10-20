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
    
}
