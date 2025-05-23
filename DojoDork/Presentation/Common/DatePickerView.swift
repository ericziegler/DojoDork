//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct DatePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate: Date = Date()
    
    var minDate: Date = Date.distantPast
    var maxDate: Date = Date.distantFuture
    var onDateSelected: ((Date) -> Void)?
    
    init(
        selectedDate: Date = Date(),
        minDate: Date = .distantPast,
        maxDate: Date = Date(),
        onDateSelected: ((Date) -> Void)? = nil
    ) {
        self._selectedDate = State(initialValue: selectedDate)
        self.minDate = minDate
        self.maxDate = maxDate
        self.onDateSelected = onDateSelected
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Select a date",
                    selection: $selectedDate,
                    in: minDate...maxDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                Spacer()
                ActionButton(title: "Done") {
                    onDateSelected?(selectedDate)
                    dismiss()
                }
                .padding(24)
            }
            .navigationTitle("Pick a Date")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .appBodyMediumStyle()
                    }

                }
            }
        }
        .preferredColorScheme(.dark)
        .tint(.brand)
    }
}

#Preview {
    DatePickerView()
}
