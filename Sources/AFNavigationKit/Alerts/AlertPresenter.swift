//
//  AlertPresenter.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import Foundation

/// A protocol for objects that wish to present alerts
///
/// Conformers who also conform to ``@Observable``  can use `activeAlert` to trigger presentations and pass down a specific alert context.
///
/// - SeeAlso: ``AlertContext``
public protocol AlertPresenter: AnyObject {
    /// The trigger use to present an alert with a specific alert context
    var activeAlert: AlertContext? { get set }
}
