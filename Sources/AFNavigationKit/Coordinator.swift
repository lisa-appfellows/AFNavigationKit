import SwiftUI

/// A unified coordinator for managing navigation paths alongside modal sheets, fullscreen covers, and alerts.
///
/// Use this coordinator to isolate routing logic out of your SwiftUI view layer.
/// To disable specific presentation workflows, simply pass `DisabledRoute` as the target generic type.
///
/// - Parameters:
///   - Page: The type representing pages navigated inside the main root stack.
///   - Fullscreen: The type representing modally presented fullscreen covers.
///   - Sheet: The type representing modally presented sheets.
///
/// ### Routing Rules
/// - **Enabled Path:** Use `ValidRoute` when a navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use `DisabledRoute` when a navigation path is disabled. Hides corresponding navigation extensions.
///
/// ### Optional Alert Presentation
/// - **Trigger**: an optional ``activeAlert`` of type ``AlertContext``.
/// - **Contract**: ``Coordinator`` conforms to ``AlertPresenter`` Use with the view modifier ``openAlert(_:)``, which takes a bound presenter to handle alert triggers and alert context configurations.
@Observable
public final class Coordinator<Page: Routable, Fullscreen: Routable, Sheet: Routable>: PageRouter, FullscreenRouter, SheetRouter, AlertPresenter {
    public typealias Page = Page
    public typealias Fullscreen = Fullscreen
    public typealias Sheet =  Sheet

    public var path = [Page]()
    public var fullscreen: Fullscreen?
    public var sheet: Sheet?

    public var activeAlert: AlertContext?

    public init() {}
}
