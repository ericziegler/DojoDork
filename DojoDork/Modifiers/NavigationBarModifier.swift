//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

/// The standard navigation bar used throughout the app
struct NavigationBarModifier<Leading: View, Trailing: View>: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode

    // MARK: - Properties

    /// The title to display at the top center of the bar
    let title: String

    /// Optional leading item (e.g. debug menu)
    let leadingItem: () -> Leading

    /// Optional trailing item (e.g. info icon)
    let trailingItem: () -> Trailing

    /// Whether the back button can be shown in this navigation bar
    let allowsBackButton: Bool

    /// Determines whether to display the back button. Pulls from the @Environment to determine if the view is "presented" .
    /// If it is, then we check that the allowsBackButton property to make sure the button can be displayed.
    private var shouldShowBackButton: Bool {
        presentationMode.wrappedValue.isPresented && allowsBackButton
    }

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if shouldShowBackButton {
                    renderBackButton()
                }
                renderLeadingItem()
                renderTitle()
                renderTrailingItem()
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.appBar), for: .navigationBar)
    }

    @ToolbarContentBuilder private func renderTitle() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(title)
                .appNavStyle()
                .foregroundColor(Color(.appText))
        }
    }

    @ToolbarContentBuilder private func renderLeadingItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            leadingItem()
                .padding(.leading, 8)
        }
    }

    @ToolbarContentBuilder private func renderTrailingItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            trailingItem()
                .padding(.trailing, 8)
        }
    }

    @ToolbarContentBuilder private func renderBackButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "")
                    .resizeAndFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(.brand))
            }
        }
    }
}

extension View {
    /// Modifier for the standard navigation bar used throughout the app
    ///
    /// > This modifier naturally tries to show a back button when it is being presented. Unfortunately, there is no way
    /// to know whether it's being presented in a NavigationStack (which should show the back button) or as a sheet
    /// (which shouldn't show a back button). If a view should NOT display a back button, set `allowsBackButton` to false.
    /// - Parameters:
    ///   - title: The text to display at the top center of the bar
    ///   - leadingItem: The @ViewBuilder allowing for views to be created in the leading area of the bar.
    ///   - trailingItem: The @ViewBuilder allowing for views to be created in the trailing area of the bar.
    ///   - allowsBackButton: If the view is in a presented context, should it show the navigation back button?
    func navigationBar<Leading: View, Trailing: View>(
        title: String,
        @ViewBuilder leadingItem: @escaping () -> Leading = { EmptyView() },
        @ViewBuilder trailingItem: @escaping () -> Trailing = { EmptyView() },
        allowsBackButton: Bool = false
    ) -> some View {
        self.modifier(
            NavigationBarModifier(
                title: title,
                leadingItem: leadingItem,
                trailingItem: trailingItem,
                allowsBackButton: allowsBackButton
            )
        )
    }
}
