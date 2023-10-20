//
//  MyListsViewModel.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation
import SwiftUI
import CoreData

final class MyListsViewModel: NSObject, ObservableObject {
    
    @Published var myLists: [MyListViewModel] = []
    private let fetchedResultsController: NSFetchedResultsController<MyList>
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.fetchedResultsController = NSFetchedResultsController(
            fetchRequest: MyList.all,
            managedObjectContext: self.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        super.init()
        self.fetchedResultsController.delegate = self
        self.fetchAll()
    }
    
    func delete(_ myList: MyListViewModel) {
        guard let myList: MyList = MyList.byId(id: myList.id) else { return }
        try? myList.delete()
    }
    
    private func fetchAll() {
        do {
            try self.fetchedResultsController.performFetch()
            guard let myLists = self.fetchedResultsController.fetchedObjects else { return }
            self.myLists = myLists.map(MyListViewModel.init)
        } catch {
            print(error)
        }
    }
    
}

extension MyListsViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let myLists = controller.fetchedObjects as? [MyList] else { return }
        self.myLists = myLists.map(MyListViewModel.init)
    }
    
}
