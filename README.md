# AFNavigationKit

![CI Status](https://github.com/lisa-appfellows/AFNavigationKit/actions/workflows/ci.yml/badge.svg)
<br>
<br>
![CD Status](https://github.com/lisa-appfellows/AFNavigationKit/actions/workflows/cd.yml/badge.svg)

## Core Feature

### Routable
- A protocol requiring `Identifiable` and `Hashable` conformances.
- A `ValidRoute` protocol that conforms to `Routable` that enables navigation methods.
- A `DisabledRoute` struct, conforming to `Routable` that hides navigation methods. 

Adding both a valid and disabled state aids conformers when utilizing the generic coordinator, or when creating their own, in allowing them to select which paths they want to apply for. Disabled routes automatically hide navigation methods, allowing for cleaner autocompletes. 

### RouteFactory
- A protocol that builds a view for a given `ValidRoute`.

Enables different valid routes (Page, Fullscreen, or Sheet) to have their own creation factories, and decouples creation from identification.

### Router
- `PageRouter`: A protocol for page routing that requires a path for a chosen route. Routes can be valid or disabled routes, but the corresponding default navigation method is hidden for non `ValidRoute` types.
- `FullscreenRouter': A protocol for fullscreen presentations. Requires an optional fullscreen property. Routes can also be value or disabled, but the navigation method is hidden from non `ValidRoute` types.
- `SheetRouter`: A protocol for sheet presentations. Requires an optional sheet property. Routes can also be value or disabled, but the navigation method is hidden from non `ValidRoute` types.

By separating types of navigations into their own router protocols, the `Coordinator` is able to pick and choose which navigation paths it will hold based on user settings.

### Coordinator
- A generic `@Observable` class, conforming to `PageRouter`, `FullscreenRouter`, and `SheetRouter`. 

The generic parameters allow users to apply a conforming ValidRoute to enable the route or the `DisabledRoute` struct to disable the route.
