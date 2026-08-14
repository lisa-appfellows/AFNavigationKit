//
//  CoordinatorFullscreenRouterTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class CoordinatorFullscreenRouterTests: XCTestCase {
    private var coordinator: Coordinator<DisabledRoute, MockCover, DisabledRoute>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_coordinator_presentFullscreen_setsProperty() {
        let slug = "title-of-article"
        coordinator.present(fullscreen: .article(slug: slug))
        
        XCTAssertEqual(coordinator.fullscreen, .article(slug: slug), "Coordinator present(fullscreen:) should assign .article(slug) to fullscreen property.")
    }
}
