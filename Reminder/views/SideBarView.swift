//
//  SideBarView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct SideBarView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Items Count 10")
            
            List(1...5, id: \.self) { index in
                Text("List: \(index)")
            }
            
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
                    context: self.viewContext))
            })
            .buttonStyle(.plain)
            .padding()

            
        } //: VStack
    } //: body
}

#Preview {
    SideBarView()
}
