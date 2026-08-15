//
//  BasicPageRouter.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import Foundation


/// A basic protocol for an object handling navigation paths.
///
/// Use when complex navigation logic is not needed.
///
/// ### Routing Rules
/// - **Enabled Path:** Use ``ValidRoute`` when a navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use ``DisabledRoute`` when a navigation path is disabled. Hides corresponding navigation extensions.
///
/// - Note: Do not use ``Routable`` directly to create a page route. See **Routing Rules**
///
/// ## Usage
/// ```swift
/// @Observable
/// final class Coordinator: BasicPageRouter {
///     typealias Page = ValidPage
///     var path = [ValidPage]()
/// }
///
/// let coordinator = Coordinator()
/// coordinator.push(page: .home)
/// ```
public protocol BasicPageRouter: AnyObject {
    associatedtype Page: Routable
    var path: [Page] { get set }
}

extension BasicPageRouter where Page: ValidRoute {
    /// Pushes a page onto the navigation path.
    public func push(page: Page) {
        path.append(page)
    }

    /// Removes the last page from the navigation path.
    public func pop() {
        path.removeLast()
    }

    /// Clears the navigation path.
    public func popToRoot() {
        path = []
    }
}
