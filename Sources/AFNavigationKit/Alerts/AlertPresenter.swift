//
//  AlertPresenter.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import SwiftUI

/// A protocol for objects that present alerts.
///
/// Conformers expose a read-only ``activeAlert`` and ``alertQueue``, typically as `public private(set)`,
/// and implement ``present(alert:)``, ``clearAlert()``, and ``queueNextAlert()`` to serialize presentations.
/// Use ``boundIsPresented`` with ``openAlert(_:)`` so dismissals clear the active alert and dequeue the next one.
///
/// ## Usage
/// ```swift
/// @Observable final class Coordinator: AlertPresenter {
///     public private(set) var activeAlert: AlertModel?
///     public private(set) var alertQueue = [AlertModel]()
///
///     func present(alert: AlertModel) {
///         if activeAlert != nil {
///             alertQueue.append(alert)
///             return
///         }
///         activeAlert = alert
///     }
///
///     func clearAlert() {
///         withAnimation {} completion: {
///             self.activeAlert = nil
///             self.queueNextAlert()
///         }
///     }
///
///     func queueNextAlert() {
///         if activeAlert == nil && !alertQueue.isEmpty {
///             activeAlert = alertQueue.removeFirst()
///         }
///     }
/// }
/// ```
public protocol AlertPresenter: AnyObject {
    /// The alert currently being presented, if any. Use ``boundIsPresented`` to bind presentation state.
    var activeAlert: AlertModel? { get }

    /// Alerts waiting to present after the active alert dismisses.
    var alertQueue: [AlertModel] { get }

    /// Presents an alert, queueing it when another alert is already active.
    func present(alert: AlertModel)

    /// Clears the active alert, accounting for animation or post-dismiss cleanup before dequeuing.
    func clearAlert()

    /// Presents the next queued alert when no alert is active.
    func queueNextAlert()
}

extension AlertPresenter {
    /// Binding for alert presentation. Setting `false` calls ``clearAlert()``.
    public var boundIsPresented: Binding<Bool> {
        Binding(
            get: { self.activeAlert != nil },
            set: { isPresented in
                if !isPresented { self.clearAlert() }
            }
        )
    }
}
