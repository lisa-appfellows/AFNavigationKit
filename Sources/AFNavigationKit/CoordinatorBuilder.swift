//
//  CoordinatorBuilder.swift
//
//
//  Created by Lisa Fellows on 2026-08-13.
//

import Foundation

/// The preferred entry point for constructing a ``Coordinator``.
///
/// Start with ``NewCoordinator``, enable only the navigation flows you need, then call ``CoordinatorBuilder/build()``.
/// Any flow you leave unconfigured remains ``DisabledRoute``, so its navigation APIs stay unavailable.
///
/// ### Usage
/// Enable every flow:
/// ```swift
/// let coordinator = NewCoordinator()
///     .addPageRouting(AppPage.self)
///     .addFullscreenRouting(AppFullscreen.self)
///     .addSheetRouting(AppSheet.self)
///     .build()
/// ```
///
/// Enable a subset (order does not matter):
/// ```swift
/// let coordinator = NewCoordinator()
///     .addPageRouting(AppPage.self)
///     .addSheetRouting(AppSheet.self)
///     .build()
/// // Fullscreen remains DisabledRoute
/// ```
///
/// Disable everything:
/// ```swift
/// let coordinator = NewCoordinator().build()
/// ```
///
/// - SeeAlso: ``Coordinator``, ``CoordinatorBuilder``
typealias NewCoordinator = CoordinatorBuilder<DisabledRoute, DisabledRoute, DisabledRoute>


/// A type-safe builder that configures which route slots a ``Coordinator`` supports.
///
/// Do not construct this type directly. Begin with ``NewCoordinator``, chain the `add*Routing`
/// methods for each ``ValidRoute`` you want enabled, then finish with ``build()``.
///
/// Each `add*Routing` call replaces that slot’s generic parameter. Slots you never configure stay
/// ``DisabledRoute``.
///
/// - SeeAlso: ``NewCoordinator``, ``Coordinator``
public struct CoordinatorBuilder<Page: Routable, Fullscreen: Routable, Sheet: Routable> {
    /// Creates an empty builder with every route slot disabled.
    ///
    /// Prefer ``NewCoordinator`` as the call-site entry point.
    public init() where Page == DisabledRoute, Fullscreen == DisabledRoute, Sheet == DisabledRoute {}

    init(factory: Void) {}
    
    /// Enables stack-based page navigation for the given ``ValidRoute`` type.
    ///
    /// The resulting coordinator’s `Page` slot becomes `NewP`, unlocking ``PageRouter`` APIs such as
    /// `push`, `pop`, and `deeplink`.
    ///
    /// - Parameter type: The page route type to enable.
    /// - Returns: A builder whose page slot is configured for `NewP`.
    public func addPageRouting<NewP: ValidRoute>(_ type: NewP.Type) -> CoordinatorBuilder<NewP, Fullscreen, Sheet> {
        CoordinatorBuilder<NewP, Fullscreen, Sheet>(factory: ())
    }

    /// Enables fullscreen-cover presentation for the given ``ValidRoute`` type.
    ///
    /// The resulting coordinator’s `Fullscreen` slot becomes `NewF`, unlocking ``FullscreenRouter`` APIs
    /// such as `present(fullscreen:)` and `dismissFullscreen()`.
    ///
    /// - Parameter type: The fullscreen route type to enable.
    /// - Returns: A builder whose fullscreen slot is configured for `NewF`.
    public func addFullscreenRouting<NewF: ValidRoute>(_ type: NewF.Type) -> CoordinatorBuilder<Page, NewF, Sheet> {
        CoordinatorBuilder<Page, NewF, Sheet>(factory: ())
    }

    /// Enables sheet presentation for the given ``ValidRoute`` type.
    ///
    /// The resulting coordinator’s `Sheet` slot becomes `NewS`, unlocking ``SheetRouter`` APIs such as
    /// `present(sheet:)` and `dismissSheet()`.
    ///
    /// - Parameter type: The sheet route type to enable.
    /// - Returns: A builder whose sheet slot is configured for `NewS`.
    public func addSheetRouting<NewS: ValidRoute>(_ type: NewS.Type) -> CoordinatorBuilder<Page, Fullscreen, NewS> {
        CoordinatorBuilder<Page, Fullscreen, NewS>(factory: ())
    }

    /// Produces a ``Coordinator`` with the route slots configured by this builder.
    ///
    /// Call this once at the end of the chain. Unconfigured slots remain ``DisabledRoute``.
    ///
    /// - Returns: A coordinator whose generics match the enabled route types.
    public func build() -> Coordinator<Page, Fullscreen, Sheet> {
        Coordinator<Page, Fullscreen, Sheet>()
    }
}
