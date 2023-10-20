//
//  HomeScreen.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationView {
            
            let myListVM = MyListsViewModel(context: self.context)
            let firstListVM = myListVM.myLists.first
            
            SideBarView()
                .frame(minWidth: 200)
            if let firstListVM {
                MyListItemsHeaderView(
                    name: firstListVM.name,
                    count: firstListVM.itemsCount,
                    color: firstListVM.color
                )
                MyListItemsView(items: firstListVM.items)
            }
            
        } //: NavigationView
    } //: body
}

#Preview {
    HomeScreen()
}
