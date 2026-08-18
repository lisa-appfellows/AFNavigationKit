//
//  RouteFactory.swift
//
//
//  Created by Lisa Fellows on 2026-08-12.
//

import SwiftUI

/// A protocol representing a view-creating factory for a specific type of ``ValidRoute``.
///
/// ### Associated Types
/// - **Route:** The type representing a navigation point. Must conform to ``ValidRoute``.
/// - **Content:** The SwiftUI view created for a given ``Route``.
public protocol RouteFactory {
    associatedtype Route: ValidRoute
    associatedtype Content: View

    @ViewBuilder static func createView(for route: Route) -> Content
}
