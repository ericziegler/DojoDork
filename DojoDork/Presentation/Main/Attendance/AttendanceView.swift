//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct AttendanceView: View {
    
    @State private var viewModel = AttendanceViewModel()
    
    var body: some View {
        Text("Attendance")
    }
}

#Preview {
    AttendanceView()
}
