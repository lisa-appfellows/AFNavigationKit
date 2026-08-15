//
//  AlertModel.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import SwiftUI

/// A model for constructing an alert presentation.
///
/// The ``id`` is generated automatically. Provide a title, message, and at least a primary ``AlertAction``.
public struct AlertModel: Identifiable, Equatable {
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

    public static func == (lhs: AlertModel, rhs: AlertModel) -> Bool {
        lhs.id == rhs.id
    }
}

/// A model for an alert button title, optional role, and action.
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
