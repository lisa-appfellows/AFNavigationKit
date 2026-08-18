//
//  BasicPageCoordinatorTests.swift
//
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class BasicPageCoordinatorTests: XCTestCase {
    private var coordinator: BasicCoordinator<MockPage, DisabledRoute, DisabledRoute>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_pushPage_appendsToPath() {
        coordinator.push(page: .home)
        
        XCTAssertEqual(coordinator.path.count, 1, "Pushed page to coordinator should show path count of 1")
        XCTAssertEqual(coordinator.path.last, .home, "Pushed home page to coordinator should show last item in path as 'home'")
    }
    
    func test_pushMultiplePages_maintainsOrder() {
        coordinator.push(page: .home)
        coordinator.push(page: .profile(userId: "user_123"))
        
        XCTAssertEqual(coordinator.path.count, 2, "Should show a path count of 2")
        XCTAssertEqual(coordinator.path[0], .home, "First item in path should be 'home'")
        XCTAssertEqual(coordinator.path[1], .profile(userId: "user_123"), "Second item in path should be 'profile' with corresponding userId")
    }

    func test_pop_shouldPopLast() {
        coordinator.push(page: .home)
        coordinator.push(page: .settings)

        XCTAssertEqual(coordinator.path, [.home, .settings], "Should have pushed home and settings onto path")

        coordinator.pop()

        XCTAssertEqual(coordinator.path, [.home], "Should have popped settings off of path")
    }

    func test_pop_onEmptyPath_doesNothing() {
        coordinator.pop()

        XCTAssertTrue(coordinator.path.isEmpty, "Popping an empty path should be a no-op")
    }

    func test_popToRoot_shouldClearPath() {
        coordinator.push(page: .home)
        coordinator.push(page: .settings)

        XCTAssertEqual(coordinator.path, [.home, .settings], "Should have pushed home and settings onto path")

        coordinator.popToRoot()

        XCTAssertTrue(coordinator.path.isEmpty, "Should have cleared path")
    }
}
