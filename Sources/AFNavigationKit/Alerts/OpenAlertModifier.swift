//
//  OpenAlertModifier.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import SwiftUI

extension View {
    /// Presents alerts driven by an ``AlertPresenter``.
    ///
    /// - Parameter presenter: A binding to an object conforming to ``AlertPresenter``.
    public func openAlert(_ presenter: Binding<any AlertPresenter>) -> some View {
        modifier(OpenAlertModifier(presenter: presenter))
    }
}

/// A view modifier that presents the presenter's ``AlertPresenter/activeAlert`` using SwiftUI's `alert` API.
public struct OpenAlertModifier: ViewModifier {
    @Binding var presenter: any AlertPresenter

    public func body(content: Content) -> some View {
        content
            .alert(
                presenter.activeAlert?.title ?? "",
                isPresented: presenter.boundIsPresented,
                presenting: presenter.activeAlert
            ) { alert in
                Button(alert.primaryAction.title, role: alert.primaryAction.role) {
                    alert.primaryAction.action()
                }

                if let secondaryAction = alert.secondaryAction {
                    Button(secondaryAction.title, role: secondaryAction.role) {
                        secondaryAction.action()
                    }
                }
            } message: { alert in
                Text(alert.message)
            }
    }
}
