//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct RosterView: View {
    
    @State private var viewModel = RosterViewModel()
    @Binding var showProfile: Bool
    @State private var isShowingSortOptions = false
    @State private var selectedStudent: Student? = nil
    @State private var isShowingAddStudentView = false
    @State private var scrollTargetStudentId = ""
    @State private var taskId: UUID = .init()
    private let bottomButtonPadding = 80.0

    var body: some View {
        NavigationStack {
            ZStack {
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
                
                renderAddButton()
            }
            .sheet(item: $selectedStudent) { student in
                StudentView(student: student) { studentId in
                    handleRosterUpdate(with: "Student updated!", studentId: studentId)
                } onStudentPromoted: { studentId in
                    handleRosterUpdate(with: "Student promoted!", studentId: studentId)
                } onStudentDeleted: {
                    handleRosterUpdate(with: "Student deleted!", studentId: nil)
                }

            }
            .sheet(isPresented: $isShowingAddStudentView, content: {
                AddStudentView { studentId in
                    Task {
                        await viewModel.loadStudents()
                        scrollTargetStudentId = studentId
                    }
                }
            })
        }
    }
    
    // MARK: - Buttons

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

    // MARK: - List Content

    @ViewBuilder private func renderStudentList() -> some View {
        ScrollViewReader { value in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.filteredStudents, id: \.id) { student in
                        StudentCard(student: student)
                            .id(student.id)
                            .padding(.horizontal)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    self.selectedStudent = student
                                }
                            }
                    }
                }
                .padding(.top)
                .padding(.bottom, bottomButtonPadding)
                .onChange(of: scrollTargetStudentId) { oldValue, newValue in
                    withAnimation {
                        value.scrollTo(newValue, anchor: .top)
                    }
                }
            }
            .refreshable {
                taskId = .init()
            }
            .task(id: taskId) {
                await viewModel.loadStudents()
            }
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
    
    private func renderAddButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                FloatingButton(systemImage: "plus") {
                    isShowingAddStudentView = true
                }
                .padding()
            }
        }
    }
    
    private func handleRosterUpdate(with message: String, studentId: String?) {
        Task {
            await viewModel.loadStudents()
            viewModel.showAlert(message: "Student promoted!")
            if let studentId {
                scrollTargetStudentId = studentId
            }
        }
    }
}

#Preview {
    RosterView(showProfile: .constant(false))
}
