//
//  EditListItemView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct EditListItemView: View {
    
    private var item: MyListItemViewModel
    @State private var selectedDate = Date.today
    @State private var showCalendar = false
    @ObservedObject private var editListItemVM: EditListItemViewModel
    private var onUpdated: () -> Void
    
    init(item: MyListItemViewModel,
         onUpdated: @escaping () -> Void) {
        self.item = item
        self.onUpdated = onUpdated
        self.editListItemVM = EditListItemViewModel(listItemVM: item)
    }
    
    private var calendarButtonTitle: String {
        self.editListItemVM.selectedDate != nil ? self.editListItemVM.selectedDate!.formatAsString : "Add Date"
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            TextField(self.item.title, text: self.$editListItemVM.title)
                .textFieldStyle(.plain)
            Divider()
            HStack {
                Text("Due Date: ")
                CalendarButtonView(
                    title: self.calendarButtonTitle,
                    showCalendar: self.$showCalendar,
                    onSelected: { date in
                        self.editListItemVM.selectedDate = date
                    }
                )
            } //: HStack
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Done") {
                    self.editListItemVM.save()
                    self.onUpdated()
                }
                .buttonStyle(.borderedProminent)
            } //: HStack
            
        }) //: VStack
        .padding()
        .frame(minWidth: 200, minHeight: 200)
    } //: body
    
} //: EditListItemView

#Preview {
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    return EditListItemView(
        item: MyListItemViewModel(myListItem: MyListItem(context: viewContext)),
        onUpdated: {}
    )
}
