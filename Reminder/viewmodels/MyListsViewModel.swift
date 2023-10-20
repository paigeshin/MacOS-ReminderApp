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
        self.setupObservsers()
        self.fetchAll()
    }
    
    private func setupObservsers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.managedOjbectContextDidChange),
            name: .NSManagedObjectContextObjectsDidChange,
            object: self.context
        )
    }
    
    @objc
    private func managedOjbectContextDidChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let updates = userInfo[NSUpdatedObjectsKey] as? Set<MyListItem>, updates.count > 0 else { return }
        self.fetchAll()
    }
    
    func saveTo(list: MyListViewModel, title: String, dueDate: Date?) {
        let myListItem = MyListItem(context: self.context)
        myListItem.title = title
        myListItem.dueDate = dueDate
        myListItem.myList = MyList.byId(id: list.id)
        try? myListItem.save()
    }

    func deleteItem(_ item: MyListItemViewModel) {
        guard let myListItem: MyListItem = MyListItem.byId(id: item.listItemID) else { return }
        try? myListItem.delete()
    }
    
    func markAsCompleted(_ item: MyListItemViewModel) {
        guard let myListItem: MyListItem = MyListItem.byId(id: item.listItemID) else { return }
        myListItem.isCompleted = true
        try? myListItem.save()
    }
    
    func delete(_ myList: MyListViewModel) {
        guard let myList: MyList = MyList.byId(id: myList.id) else { return }
        try? myList.delete()
    }
    
    private func fetchAll() {
        try? self.fetchedResultsController.performFetch()
        guard let myLists = self.fetchedResultsController.fetchedObjects else { return }
        self.myLists = myLists.map(MyListViewModel.init)
    }
    
}

extension MyListsViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let myLists = controller.fetchedObjects as? [MyList] else { return }
        self.myLists = myLists.map(MyListViewModel.init)
    }
    
}
