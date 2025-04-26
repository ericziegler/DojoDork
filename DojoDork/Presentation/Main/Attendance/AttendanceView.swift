//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct AttendanceView: View {
    
    @State private var viewModel = AttendanceViewModel()
    @Binding var showProfile: Bool
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                Text("Attendance")
            }
            .navigationBar(title: "Attendance", leadingItem: {
                renderNavButton()
            })
        }
    }
    
    @ViewBuilder private func renderNavButton() -> some View {
        Button {
            showProfile.toggle()
        } label: {
            Image(systemName: "gearshape.fill")
                .fontWeight(.semibold)
        }
        .tint(.brand)
    }
}

#Preview {
    AttendanceView(showProfile: .constant(false))
}
