//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct RosterView: View {
    
    @State private var viewModel = RosterViewModel()
    @Binding var showProfile: Bool
    @State private var isShowingSortOptions = false
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                if viewModel.isLoading && viewModel.students.isEmpty {
                    LoadingView()
                } else if viewModel.students.isEmpty {
                    renderContentUnavailable()
                } else {
                    renderStudentList()
                }
            }
            .navigationBar(title: "Roster", leadingItem: {
                renderProfileButton()
            }, trailingItem: {
                renderSortButton()
            })
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            }
            .confirmationDialog("Sort By", isPresented: $isShowingSortOptions, titleVisibility: .visible) {
                ForEach(RosterSortOption.allCases) { option in
                    Button(option.rawValue) {
                        viewModel.sortOption = option
                        viewModel.sortStudents()
                    }
                }
            }
            .task {
                await viewModel.loadStudents()
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
    
    @ViewBuilder private func renderStudentList() -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.filteredStudents, id: \.studentId) { studentSummary in
                    StudentCard(student: studentSummary)
                }
            }
            .padding()
        }
        .refreshable {
            await viewModel.loadStudents()
        }
    }
    
    @ViewBuilder private func renderContentUnavailable() -> some View {
        ContentUnavailableView {
            Image(systemName: "list.clipboard.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.bottom, 8)
        } description: {
            Text("No students found.")
                .appLinkStyle()
        } actions: {
            LinkButton(title: "Refresh") {
                Task {
                    await viewModel.loadStudents()
                }
            }
        }
    }
}

#Preview {
    RosterView(showProfile: .constant(false))
}
