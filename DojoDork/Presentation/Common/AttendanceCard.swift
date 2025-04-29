//
// Created by Eric Ziegler on 4/28/25
//  

import SwiftUI

struct AttendanceCard: View {
    let student: Student
    
    var body: some View {
        HStack(alignment: .center) {
            renderName()
            Spacer()
            renderStatus()
        }
        .padding(.vertical, 24)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appCard)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appSeparator, lineWidth: 1)
        )
    }
    
    @ViewBuilder private func renderName() -> some View {
        Text(student.name)
            .appHeaderStyle()
            .foregroundStyle(.appText)
    }
    
    @ViewBuilder private func renderStatus() -> some View {
        switch student.attendanceStatus {
        case .updating:
            ProgressView()
                .frame(width: 26, height: 26)
                .progressViewStyle(CircularProgressViewStyle(tint: .appSecondaryText))

        case .attended:
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 26)
                .foregroundStyle(.brand)

        case .notAttended:
            Image(systemName: "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 26)
                .foregroundStyle(.appSecondaryText)
        }
    }
}

#Preview {
    AttendanceCard(
        student: .mockData
    )
    .padding()
}
