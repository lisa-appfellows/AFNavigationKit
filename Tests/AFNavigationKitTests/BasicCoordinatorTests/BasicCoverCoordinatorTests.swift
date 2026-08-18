//
//  BasicCoverCoordinatorTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class BasicCoverCoordinatorTests: XCTestCase {
    private var coordinator: BasicCoordinator<DisabledRoute, MockCover, DisabledRoute>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_presentCover_setsProperty() {
        let slug = "title-of-article"
        coordinator.present(cover: .article(slug: slug))
        
        XCTAssertEqual(coordinator.cover, .article(slug: slug), "Coordinator present(cover:) should assign .article(slug) to cover property.")
    }

    func test_dismissCover_clearsProperty() {
        let slug = "slug"
        coordinator.present(cover: .article(slug: slug))

        XCTAssertEqual(coordinator.cover, .article(slug: slug), "Coordinator present(cover:) should assign .article(slug) to cover property.")

        coordinator.dismissCover()

        XCTAssertNil(coordinator.cover, "Should have set cover property to nil")
    }
}
