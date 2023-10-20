//
//  ReminderApp.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

@main
struct ReminderApp: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.persistentContainer.viewContext
            HomeScreen()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
