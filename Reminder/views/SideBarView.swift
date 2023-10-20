//
//  SideBarView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct SideBarView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Items Count 10")
            
            MyListsView(vm: MyListsViewModel(context: self.context))
            
            Spacer()
            
            Button {
                self.isPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: Constants.Icons.plusCircle)
                    Text("Add List")
                } //: HStack
            }
            .sheet(isPresented: self.$isPresented, content: {
                AddNewListView(vm: AddNewListViewModel(
                    context: self.context))
            })
            .buttonStyle(.plain)
            .padding()

            
        } //: VStack
    } //: body
}

#Preview {
    SideBarView()
}
