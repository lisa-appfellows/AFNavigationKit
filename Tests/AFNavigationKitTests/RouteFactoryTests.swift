//
//  RouteFactoryTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class RouteFactoryTests: XCTestCase {
    func test_pageRoute_didCreateView() {
        let route = MockPage.profile(userId: "123")

        let createdView = MockFactory<MockPage>.createView(for: route)
        let detectableView = createdView as? DetectableView

        XCTAssertEqual(detectableView?.routeId, route.id)
    }

    func test_fullscreenRoute_didCreateView() {
        let route = MockCover.article(slug: "this-article")

        let createdView = MockFactory<MockCover>.createView(for: route)
        let detectableView = createdView as? DetectableView

        XCTAssertEqual(detectableView?.routeId, route.id)
    }

    func test_sheetRoute_didCreateView() {
        let route = MockSheet.playSettings

        let createdView = MockFactory<MockSheet>.createView(for: route)
        let detectableView = createdView as? DetectableView

        XCTAssertEqual(detectableView?.routeId, route.id)
    }
}
