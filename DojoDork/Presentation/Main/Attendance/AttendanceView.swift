//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct AttendanceView: View {
    
    @State private var viewModel = AttendanceViewModel()
    @State private var isShowingSortOptions = false
    @Binding var showProfile: Bool
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                Text("Attendance")
            }
            .navigationBar(title: "Attendance", leadingItem: {
                renderProfileButton()
            }, trailingItem: {
                renderSortButton()
            })
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .confirmationDialog("Sort By", isPresented: $isShowingSortOptions, titleVisibility: .visible) {
                ForEach(RosterSortOption.allCases) { option in
                    Button(option.rawValue) {
                        viewModel.sortOption = option
                        viewModel.sortStudents()
                    }
                }
            }
        }
    }
    
    @ViewBuilder private func renderProfileButton() -> some View {
        Button {
            showProfile.toggle()
        } label: {
            Image(systemName: "gearshape.fill")
                .fontWeight(.semibold)
        }
        .tint(.brand)
    }
    
    @ViewBuilder private func renderSortButton() -> some View {
        Button {
            isShowingSortOptions = true
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .fontWeight(.semibold)
        }
        .tint(.brand)
    }
}

#Preview {
    AttendanceView(showProfile: .constant(false))
}
