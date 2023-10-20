//
//  DueDateSelectionView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct DueDateSelectionView: View {
    
    @Binding var dueDate: DueDate?
    @State private var selectedDate = Date.today
    @State private var showCalendar = false
    
    var body: some View {
        Menu {
            Button {
                self.dueDate = .today
            } label: {
                VStack {
                    Text("Today \n \(Date.today.formatAsString)")
                } //: VStack
            }
            
            Button {
                self.dueDate = .tomorrow
            } label: {
                VStack {
                    Text("Tomorrow \n \(Date.today.formatAsString)")
                } //: VStack
            }
            
            Button {
                self.showCalendar.toggle()
            } label: {
                VStack {
                    Text("Custom")
                } //: VStack
            }
            
        } label: {
            let title = self.dueDate == nil ? "Add Date:" : self.dueDate!.title
            Label(title, systemImage: "calendar")
        } //: Menu
        .menuStyle(.borderedButton)
        .fixedSize()
        .popover(isPresented: self.$showCalendar, content: {
            DatePicker("Custom",
                       selection: self.$selectedDate,
                       displayedComponents: .date)
            .labelsHidden()
            .datePickerStyle(.graphical)
            .onChange(of: self.selectedDate, { _, newValue in
                self.dueDate = .custom(newValue)
                self.showCalendar = false
            })
        })
    } //: body
}

#Preview {
    DueDateSelectionView(dueDate: .constant(nil))
}
