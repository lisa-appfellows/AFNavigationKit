//
//  BasicCoverRouter.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import Foundation

/// A basic protocol for an object handling fullscreen cover presentations.
///
/// Use when complex cover presentation logic is not needed.
///
/// ### Routing Rules
/// - **Enabled Path:** Use ``ValidRoute`` when a navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use ``DisabledRoute`` when a navigation path is disabled. Hides corresponding navigation extensions.
///
/// - Note: Do not use ``Routable`` directly to create a cover route. See **Routing Rules**
///
/// ## Usage
/// ```swift
/// @Observable
/// final class Coordinator: BasicCoverRouter {
///     typealias Cover = ValidCover
///     var cover: ValidCover?
/// }
///
/// let coordinator = Coordinator()
/// coordinator.present(cover: .settings)
/// ```
public protocol BasicCoverRouter: AnyObject {
    associatedtype Cover: Routable
    var cover: Cover? { get set }
}

extension BasicCoverRouter where Cover: ValidRoute {
    /// Presents a fullscreen cover for the given route.
    public func present(cover: Cover) {
        self.cover = cover
    }

    /// Dismisses the currently presented fullscreen cover.
    public func dismissCover() {
        cover = nil
    }
}
