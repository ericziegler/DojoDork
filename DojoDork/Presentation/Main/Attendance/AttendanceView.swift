//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct AttendanceView: View {
    
    @State private var viewModel = AttendanceViewModel()
    @State private var isShowingSortOptions = false
    @State private var showDatePicker = false
    @State private var taskId: UUID = .init()
    @State private var hapticFeedback = false
    @Binding var showProfile: Bool
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                VStack(spacing: 0) {
                    renderDateBar()
                    if viewModel.isLoading && viewModel.students.isEmpty {
                        LoadingView()
                    } else if viewModel.students.isEmpty {
                        renderContentUnavailable()
                    } else {
                        renderAttendanceList()
                    }
                }
            }
            .navigationBar(title: "Attendance", leadingItem: {
                renderProfileButton()
            }, trailingItem: {
                renderSortButton()
            })
            .sensoryFeedback(.impact, trigger: hapticFeedback)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .confirmationDialog("Sort By", isPresented: $isShowingSortOptions, titleVisibility: .visible) {
                ForEach(RosterSortOption.allCases) { option in
                    Button(option.rawValue) {
                        viewModel.sortOption = option
                        viewModel.sortStudents()
                    }
                }
            }
            .task(id: taskId) {
                await viewModel.loadStudents()
            }
        }
    }
    
    @ViewBuilder private func renderDateBar() -> some View {
        HStack {
            Spacer()
            Button {
                showDatePicker = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .offset(y: -1)
                    Text("\(viewModel.formattedDate)")
                        .appButtonStyle()
                }
                .padding(.vertical, 16)
                .foregroundStyle(.appText)
            }
            Spacer()
        }
        .background(.appCard)
        .sheet(isPresented: $showDatePicker) {
            DatePickerView(selectedDate: viewModel.classDate) { date in
                viewModel.classDate = date
                Task {
                    await viewModel.loadStudents()
                }
            }
        }
    }
    
    @ViewBuilder private func renderAttendanceList() -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.filteredStudents, id: \.id) { student in
                    AttendanceCard(student: student)
                        .id(student.id)
                        .padding(.horizontal)
                        .onTapGesture {
                            hapticFeedback.toggle()
                            Task {
                                await viewModel.toggleAttendance(for: student.id)
                            }
                        }
                }
            }
            .padding(.vertical, 16)
        }
        .refreshable {
            taskId = .init()
        }
        .task(id: taskId) {
            await viewModel.loadStudents()
        }
    }
    
    @ViewBuilder private func renderContentUnavailable() -> some View {
        ContentUnavailableView {
            Image(systemName: "person.fill.checkmark")
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
