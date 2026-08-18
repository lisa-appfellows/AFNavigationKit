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
    /// - Parameter presenter: An object conforming to ``AlertPresenter``.
    public func openAlert<Presenter: AlertPresenter>(_ presenter: Presenter) -> some View {
        modifier(OpenAlertModifier(presenter: presenter))
    }
}

/// A view modifier that presents the presenter's ``AlertPresenter/activeAlert`` using SwiftUI's `alert` API.
public struct OpenAlertModifier<Presenter: AlertPresenter>: ViewModifier {
    private let presenter: Presenter

    public init(presenter: Presenter) {
        self.presenter = presenter
    }

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
