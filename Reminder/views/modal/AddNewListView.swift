//
//  AddNewListView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var vm: AddNewListViewModel
    
    init(vm: AddNewListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        Form {
            
            VStack(alignment: .leading) {
            
                Text("New List")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Name: ")
                    TextField("", text: self.$vm.name)
                } //: HStack
                
                HStack {
                    Text("Color:")
                    ColorListView(selectedColor: self.$vm.color)
                } //: HStack
                
            } //: VStack
            
            HStack {
                Spacer()
                Button("Cancel") {
                    self.dismiss()
                }
                Button("OK") {
                    self.vm.save()
                    self.dismiss()
                }
                .disabled(self.vm.name.isEmpty)
            } //: HStack
            
            
        } //: Form
        .frame(minWidth: 300)
        .padding()
    }
}

#Preview {
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    return AddNewListView(vm: AddNewListViewModel(context: viewContext))
}
