//
//  OpenAlertModifier.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import SwiftUI

extension View {
    /// A trigger modifier to display alerts with a given alert context.
    ///
    /// - Parameter presenter: A Bound object conforming to ``AlertPresenter``
    public func openAlert(_ presenter: Binding<any AlertPresenter>) -> some View {
        modifier(OpenAlertModifier(presenter: presenter))
    }
}

public struct OpenAlertModifier: ViewModifier {
    @Binding var presenter: any AlertPresenter

    public func body(content: Content) -> some View {
        content
            .alert(
                presenter.activeAlert?.title ?? "",
                isPresented: Binding(
                    get: { presenter.activeAlert != nil },
                    set: { isPresented in if !isPresented { presenter.activeAlert = nil } }
                ),
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
