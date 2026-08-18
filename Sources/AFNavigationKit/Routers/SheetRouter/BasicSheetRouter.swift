//
//  BasicSheetRouter.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import Foundation

/// A basic protocol for an object handling sheet presentations.
///
/// Use when complex sheet presentation logic is not needed.
///
/// ### Routing Rules
/// - **Enabled Path:** Use ``ValidRoute`` when a navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use ``DisabledRoute`` when a navigation path is disabled. Hides corresponding navigation extensions.
///
/// - Note: Do not use ``Routable`` directly to create a sheet route. See **Routing Rules**
///
/// ## Usage
/// ```swift
/// @Observable
/// final class Coordinator: BasicSheetRouter {
///     typealias Sheet = ValidSheet
///     var sheet: ValidSheet?
/// }
///
/// let coordinator = Coordinator()
/// coordinator.present(sheet: .colorTheme)
/// ```
public protocol BasicSheetRouter: AnyObject {
    associatedtype Sheet: Routable
    var sheet: Sheet? { get set }
}

extension BasicSheetRouter where Sheet: ValidRoute {
    /// Presents a sheet for the given route.
    public func present(sheet: Sheet) {
        self.sheet = sheet
    }

    /// Dismisses the currently presented sheet.
    public func dismissSheet() {
        sheet = nil
    }
}
