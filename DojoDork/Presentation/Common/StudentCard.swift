//
// Created by Eric Ziegler on 4/26/25
//  

import SwiftUI

struct StudentCard: View {
    let student: StudentSummary
    
    private var lastPromoted: String {
        if let promoDateString = student.lastPromotionDate,
           let promoDate = DateFormatter.attendance.date(from: promoDateString) {
            return DateFormatter.display.string(from: promoDate)
        } else {
            return "N/A"
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            renderStudentInfo()

            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                VStack {
                    Text("\(student.classesSinceLastPromotion)")
                        .appHeaderStyle()
                        .foregroundStyle(.brand)
                    
                    Text("Classes")
                        .appCaptionStyle()
                        .foregroundStyle(.appSecondaryText)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appCard)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appSeparator, lineWidth: 1)
        )
    }
    
    @ViewBuilder private func renderStudentInfo() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(student.studentName)
                .appHeaderStyle()
                .foregroundStyle(.appText)
            
            Text("Promoted: \(lastPromoted)")
                .appCaptionStyle()
                .foregroundStyle(.appSecondaryText)
        }
    }
}

#Preview {
    StudentCard(
        student: .mockData
    )
    .padding()
    .background(Color.appBackground)
}
