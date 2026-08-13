//
//  Mocks.swift
//
//
//  Created by Lisa Fellows on 2026-08-13.
//

import Foundation
@testable import AFNavigationKit

enum MockPageRoute: ValidRoute {
    case home
    case profile(userId: String)

    var id: String {
        switch self {
        case .home: 
            return "home"
        case .profile(let userId):
            return "profile_\(userId)"
        }
    }
}

enum MockFullscreenRoute: String, ValidRoute {
    case privacyPage
    case termsConditions

    var id: String { rawValue }
}

enum MockSheetRoute: String, ValidRoute {
    case colorTheme
    case playSettings

    var id: String { rawValue }
}
