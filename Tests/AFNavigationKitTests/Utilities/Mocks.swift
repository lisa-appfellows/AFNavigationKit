//
//  Mocks.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import SwiftUI
@testable import AFNavigationKit

// MARK: - ValidRoute
enum MockPage: ValidRoute {
    case home
    case profile(userId: String)
    case settings

    var id: String {
        var configured = "page_"

        switch self {
        case .home:
            configured += "home"
        case .profile(let userId):
            configured += "profile_\(userId)"
        case .settings:
            configured += "settings"
        }

        return configured
    }
}

enum MockCover: ValidRoute {
    case article(slug: String)

    var id: String {
        switch self {
        case .article(let slug):
            return "cover_article_\(slug)"
        }
    }
}

enum MockSheet: String, ValidRoute {
    case colorTheme
    case playSettings

    var id: String { rawValue }
}

// MARK: - RouteFactory
enum MockFactory<Route: ValidRoute>: RouteFactory {
    @ViewBuilder
    static func createView(for route: Route) -> some View {
        DetectableView(routeId: (route.id as? String) ?? "")
    }
}

struct DetectableView: View {
    let routeId: String

    var body: some View {
        Text("Hello, world")
    }
}
