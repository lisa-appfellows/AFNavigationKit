//
//  Routable.swift
//
//
//  Created by Lisa Fellows on 2026-08-12.
//

import Foundation

/// A protocol representing a navigational type.
/// Conformers should not conform to this protocol directly.
///
/// ### Routing Rules
/// - **Enabled Path:** Use ``ValidRoute`` when a navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use ``DisabledRoute`` when a navigation path is disabled. Hides corresponding navigation extensions.
public protocol Routable: Identifiable, Hashable {}

/// The primary protocol for users to conform their navigational points to.
/// Conforming unlocks navigation extensions.
public protocol ValidRoute: Routable {}

/// A public token used to represent a disabled navigational route.
/// Use this type parameter inside Coordinators when you wish to disable a route.
public struct DisabledRoute: Routable {
    public var id: String { "RoutingKit.DisabledRoute" }
    private init() {}
}
