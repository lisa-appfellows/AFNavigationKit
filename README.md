# AFNavigationKit

![CI Status](https://github.com/lisa-appfellows/AFNavigationKit/actions/workflows/ci.yml/badge.svg)
<br>
<br>
![CD Status](https://github.com/lisa-appfellows/AFNavigationKit/actions/workflows/cd.yml/badge.svg)
<br>
<br>
[![License: Proprietary EULA](https://img.shields.io/badge/License-Proprietary%20EULA-red.svg)](https://github.com/lisa-appfellows/AFNavigationKit/blob/main/LICENSE)
<br>
<br>
[![Documentation](https://img.shields.io/badge/DocC-Documentation-FFA500?logo=apple)](https://lisa-appfellows.github.io/AFNavigationKit/documentation/afnavigationkit/)
<br>
<br>

A lightweight SwiftUI navigation kit for isolating routing logic from your view layer. Define typed routes, opt into the navigation paths you need, and present pages, fullscreen covers, sheets, and alerts through a single generic coordinator.

This package is published for personal use and convenience. It is not a supported product, and ongoing maintenance is not guaranteed.

**Version:** 2.0.0  
**Platforms:** iOS 17+, macOS 14+  
**Swift:** 5.9+

## Installation

Add AFNavigationKit to your project with Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/lisa-appfellows/AFNavigationKit.git", from: "2.0.0")
]
```

Then add `AFNavigationKit` to your target dependencies.

## Overview

AFNavigationKit separates **what** you navigate to from **how** those destinations are presented. Routes identify destinations. Factories build views. Routers own presentation state. `BasicCoordinator` ties them together—and lets you disable any path you do not need.

### Routing rules

| Path state | Type | Effect |
| --- | --- | --- |
| **Enabled** | Conform to `ValidRoute` | Unlocks the corresponding navigation APIs |
| **Disabled** | Pass `DisabledRoute` | Hides those navigation APIs from autocomplete |

This pattern keeps coordinators focused: enable only the presentation styles your feature uses.

---

## Core Features

### Routable

`Routable` is the base protocol for navigational types. It requires `Identifiable` and `Hashable`. **Do not conform to `Routable` directly.**

| Type | Role |
| --- | --- |
| `ValidRoute` | Primary protocol for real destinations. Conforming unlocks navigation extensions. |
| `DisabledRoute` | Public token representing a disabled path. Pass it as a generic parameter when a coordinator should not support that presentation style. |

```swift
enum AppRoute: ValidRoute {
    case home
    case profile(userId: String)
    case settings

    var id: String {
        switch self {
        case .home: return "home"
        case .profile(let userId): return "profile_\(userId)"
        case .settings: return "settings"
        }
    }
}
```

### RouteFactory

A protocol that builds a SwiftUI view for a given `ValidRoute`. Each route family (page, cover, or sheet) can have its own factory, keeping view creation decoupled from route identification.

| Associated type | Purpose |
| --- | --- |
| `Route` | The destination type; must conform to `ValidRoute` |
| `Content` | The SwiftUI view produced for that route |

```swift
struct AppRouteFactory: RouteFactory {
    @ViewBuilder
    static func createView(for route: AppRoute) -> some View {
        switch route {
        case .home: HomeView()
        case .profile(let userId): ProfileView(userId: userId)
        case .settings: SettingsView()
        }
    }
}
```

### Routers

Presentation is split into protocols so a coordinator can opt into only the paths it needs:

| Protocol | State | Navigation API (when route is `ValidRoute`) |
| --- | --- | --- |
| `BasicPageRouter` | `path: [Page]` | `push(page:)`, `pop()`, `popToRoot()` |
| `BasicCoverRouter` | `cover: Cover?` | `present(cover:)`, `dismissCover()` |
| `BasicSheetRouter` | `sheet: Sheet?` | `present(sheet:)`, `dismissSheet()` |

Routes on each router may be a `ValidRoute` or `DisabledRoute`. Default navigation methods appear only for `ValidRoute` types, which keeps autocomplete clean when a path is turned off.

### BasicCoordinator

An `@Observable` class that conforms to `BasicPageRouter`, `BasicCoverRouter`, `BasicSheetRouter`, and `AlertPresenter`. Use it for basic navigation when complex routing logic is not needed.

Generic parameters select which paths are active:

| Parameter | Meaning |
| --- | --- |
| `Page` | Destinations on the root navigation stack |
| `Cover` | Fullscreen cover destinations |
| `Sheet` | Sheet destinations |

Pass a `ValidRoute`-conforming type to enable a path, or `DisabledRoute` to disable it.

```swift
// Pages only
typealias PageOnlyCoordinator = BasicCoordinator<AppRoute, DisabledRoute, DisabledRoute>

// Pages + sheets
typealias PageAndSheetCoordinator = BasicCoordinator<AppRoute, DisabledRoute, AppRoute>

// All presentation styles
typealias AppCoordinator = BasicCoordinator<AppRoute, AppRoute, AppRoute>
```

```swift
let coordinator = PageOnlyCoordinator()

coordinator.push(page: .home)
coordinator.push(page: .profile(userId: "42"))
coordinator.pop()
coordinator.popToRoot()
```

When a path is enabled:

```swift
coordinator.present(cover: .settings)
coordinator.present(sheet: .profile(userId: "42"))
coordinator.dismissCover()
coordinator.dismissSheet()
```

### Alerts

`BasicCoordinator` also conforms to `AlertPresenter`. Present alerts with `AlertModel` / `AlertAction`; incoming alerts queue while one is active. Attach the presenter in SwiftUI with `openAlert(_:)`.

```swift
let alert = AlertModel(
    title: "Delete item?",
    message: "This cannot be undone.",
    primaryAction: AlertAction(title: "Delete", role: .destructive) {
        // handle delete
    },
    secondaryAction: AlertAction(title: "Cancel", role: .cancel) {}
)

coordinator.present(alert: alert)
```

```swift
SomeView()
    .openAlert(coordinator)
```

---

## Documentation

Full API documentation is available via DocC:

[AFNavigationKit Documentation](https://lisa-appfellows.github.io/AFNavigationKit/documentation/afnavigationkit/)

## License

Copyright © 2026 Lisa Fellows. All rights reserved.

AFNavigationKit is a personal library. You may use it in compiled/imported form in personal and commercial apps under the terms of the [LICENSE](LICENSE) (EULA). Source redistribution, modification, and derivative works are not permitted. The software is provided as-is, without warranty, and without any promise of continued support or maintenance.
