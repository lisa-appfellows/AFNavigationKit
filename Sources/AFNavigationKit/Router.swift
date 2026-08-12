//
//  Router.swift
//
//
//  Created by Lisa Fellows on 2026-08-12.
//

import Foundation

// MARK: - PageRouter

/// Protocol for an object handling navigation paths.
///
/// Classes conforming to `PageRouter` gain default implementations for mutating paths and deeplinking
///
/// - **AssociatedType Page:** The type representing pages navigated in the root navigational stack.
///
/// ### Routing Rules
/// - **Enabled Path:** Use `ValidRoute` when navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use `DisabledRoute` when navigation path is disabled. Hides corresponding navigation extensions.
public protocol PageRouter: AnyObject {
    associatedtype Page: Routable
    var path: [Page] { get set }
}

public extension PageRouter where Page: ValidRoute {
    func push(page: Page) {
        path.append(page)
    }

    func deeplink(_ path: [Page]) {
        self.path = path
    }
}

// MARK: - FullscreenRouter

/// Protocol for an object handling fullscreen cover presentations.
///
/// Classes conforming to `FullscreenRouter` gain default implementations for presenting a new fullscreen.
///
/// - **AssociatedType Fullscreen:** The type representing fullscreen covers modally presented.
///
/// ### Routing Rules
/// - **Enabled Path:** Use `ValidRoute` when navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use `DisabledRoute` when navigation path is disabled. Hides corresponding navigation extensions.
public protocol FullscreenRouter: AnyObject {
    associatedtype Fullscreen: Routable
    var fullscreen: Fullscreen? { get set }
}

public extension FullscreenRouter where Fullscreen: ValidRoute {
    func present(fullscreen: Fullscreen) {
        self.fullscreen = fullscreen
    }
}

// MARK: - SheetRouter

/// Protocol for an object handling sheet presentations.
///
/// Classes conforming to `SheetRouter` gain default implementations for presenting a new sheet.
///
/// - **AssociatedType Sheet:** The type representing sheets modally presented. Must conform to `ValidRoute` if navigation is desired..
///
/// ### Routing Rules
/// - **Enabled Path:** Use `ValidRoute` when navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use `DisabledRoute` when navigation path is disabled. Hides corresponding navigation extensions.
public protocol SheetRouter: AnyObject {
    associatedtype Sheet: Routable
    var sheet: Sheet? { get set }
}

public extension SheetRouter where Sheet: ValidRoute {
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
}
