//
//  AddNewListViewModel.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation
import CoreData
import SwiftUI

final class AddNewListViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var color: Color = .blue
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save() {
        do {
            let myList = MyList(context: self.context)
            myList.name = name
            myList.color = NSColor(self.color)
            try myList.save()
        } catch {
            print(error)
        }
    }
    
}
