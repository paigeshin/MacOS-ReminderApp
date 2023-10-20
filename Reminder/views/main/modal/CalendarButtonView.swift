//
//  CalendarButtonView.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct CalendarButtonView: View {
    
    let title: String
    @Binding var showCalendar: Bool
    @State var selectedDate = Date.today
    var onSelected: (Date) -> Void
    
    var body: some View {
        VStack {
            Button(self.title) {
                self.showCalendar = true
            }
            .popover(isPresented: self.$showCalendar, content: {
                DatePicker("Custom", selection: self.$selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .onChange(of: self.selectedDate) { _, newValue in
                        self.onSelected(newValue)
                        self.showCalendar = false
                    }
            })
        }
    }
}

#Preview {
    CalendarButtonView(title: "hi", showCalendar: .constant(false), onSelected: { _ in })
}
