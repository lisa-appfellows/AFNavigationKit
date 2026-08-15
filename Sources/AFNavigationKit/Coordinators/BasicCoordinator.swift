import SwiftUI

/// A basic coordinator for managing navigation paths alongside modal sheets, fullscreen covers, and alerts.
///
/// Use this coordinator for basic navigation when complex navigation logic is not needed.
/// To disable specific presentation workflows, simply pass ``DisabledRoute`` as the target generic type.
///
/// ### Routing Rules
/// - **Enabled Path:** Use ``ValidRoute`` when a navigation path is desired. Unlocks corresponding navigation extensions.
/// - **Disabled Path:** Use ``DisabledRoute`` when a navigation path is disabled. Hides corresponding navigation extensions.
///
/// ## Usage
/// ```swift
/// let pageCoordinator = BasicCoordinator<ValidPage, DisabledRoute, DisabledRoute>()
/// pageCoordinator.push(page: .home)
///
/// let pageSheetCoordinator = BasicCoordinator<ValidPage, DisabledRoute, ValidSheet>()
/// pageSheetCoordinator.push(page: .home)
/// pageSheetCoordinator.present(sheet: .colorTheme)
///
/// let coordinator = BasicCoordinator<ValidPage, ValidCover, ValidSheet>()
/// coordinator.dismissSheet()
/// coordinator.popToRoot()
/// coordinator.present(cover: .privacyPolicy)
/// ```
///
/// ## Generics
/// - **Page**: The type representing pages navigated inside the main root stack.
/// - **Cover**: The type representing modally presented fullscreen covers.
/// - **Sheet**: The type representing modally presented sheets.
@Observable
public final class BasicCoordinator<Page: Routable, Cover: Routable, Sheet: Routable> {
    public var path = [Page]()
    public var cover: Cover?
    public var sheet: Sheet?

    public private(set) var activeAlert: AlertModel?
    public private(set) var alertQueue = [AlertModel]()

    public init() {}

    public func present(alert: AlertModel) {
        if activeAlert != nil {
            alertQueue.append(alert)
            return
        }

        activeAlert = alert
    }

    public func clearAlert() {
        withAnimation {} completion: {
            self.activeAlert = nil
            self.queueNextAlert()
        }
    }

    public func queueNextAlert() {
        if activeAlert == nil && !alertQueue.isEmpty {
            let newAlert = alertQueue.removeFirst()
            activeAlert = newAlert
        }
    }
}

extension BasicCoordinator: BasicPageRouter, BasicCoverRouter, BasicSheetRouter, AlertPresenter {}
