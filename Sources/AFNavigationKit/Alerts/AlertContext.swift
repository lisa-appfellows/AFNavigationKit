//
//  AlertContext.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import SwiftUI

/// A model for constructing an alert presentation.
///
/// - Parameters:
///     - id: A self-generated UUID
///     - title: The alert's title
///     - message: The alert's message
///     - primaryAction: A model for the primary alert button (see ``AlertAction``)
///     - secondaryAction: An optional model for a secondary alert button (see ``AlertAction``)
public struct AlertContext: Identifiable {
    public let id = UUID()
    public let title: String
    public let message: String
    public let primaryAction: AlertAction
    public let secondaryAction: AlertAction?

    public init(
        title: String,
        message: String,
        primaryAction: AlertAction,
        secondaryAction: AlertAction? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

/// A model for constructing an alert button.
public struct AlertAction {
    public let title: String
    public let role: ButtonRole?
    public let action: () -> Void

    public init(title: String, role: ButtonRole?, action: @escaping () -> Void) {
        self.title = title
        self.role = role
        self.action = action
    }
}
