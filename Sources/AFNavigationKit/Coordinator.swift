import SwiftUI

/// A unified navigation coordinator for a push stack, fullscreen covers, and sheets.
///
/// Construct instances with ``NewCoordinator`` rather than calling the initializer directly.
/// Enable only the flows you need; each unconfigured slot stays ``DisabledRoute`` and hides that
/// flow’s navigation methods.
///
/// ```swift
/// let coordinator = NewCoordinator()
///     .addPageRouting(AppPage.self)
///     .addSheetRouting(AppSheet.self)
///     .build()
///
/// coordinator.push(page: .home)
/// coordinator.present(sheet: .settings)
/// // fullscreen APIs are unavailable — that slot is DisabledRoute
/// ```
///
/// ### Route slots
/// - **Enabled:** Pass a ``ValidRoute`` via the builder to unlock that flow’s router APIs.
/// - **Disabled:** Leave the slot unconfigured (or use ``DisabledRoute``) to hide those APIs.
///
/// - Parameters:
///   - Page: Pages pushed on the root navigation stack.
///   - Fullscreen: Fullscreen covers presented modally.
///   - Sheet: Sheets presented modally.
///
/// - SeeAlso: ``NewCoordinator``, ``CoordinatorBuilder``, ``PageRouter``, ``FullscreenRouter``, ``SheetRouter``
@Observable
public final class Coordinator<Page: Routable, Fullscreen: Routable, Sheet: Routable>: PageRouter, FullscreenRouter, SheetRouter {
    public typealias Page = Page
    public typealias Fullscreen = Fullscreen
    public typealias Sheet =  Sheet

    public var path = [Page]()
    public var fullscreen: Fullscreen?
    public var sheet: Sheet?

    /// Creates an unconfigured coordinator.
    ///
    /// Prefer ``NewCoordinator`` so route slots are selected through the type-safe builder chain.
    init() {}
}

extension Coordinator where Fullscreen:ValidRoute, Sheet: ValidRoute {
    /// Dismisses any presented fullscreen cover and sheet.
    public func dismissAll() {
        dismissFullscreen()
        dismissSheet()
    }
}
