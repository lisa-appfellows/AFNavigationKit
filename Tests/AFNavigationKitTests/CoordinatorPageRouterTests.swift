//
//  CoordinatorPageRouterTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class CoordinatorPageRouterTests: XCTestCase {
    private var coordinator: Coordinator<MockPage, DisabledRoute, DisabledRoute>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_coordinator_pushPage_appendsToPath() {
        coordinator.push(page: .home)
        
        XCTAssertEqual(coordinator.path.count, 1, "Pushed page to coordinator should show path count of 1")
        XCTAssertEqual(coordinator.path.last, .home, "Pushed home page to coordinator should show last item in path as 'home'")
    }
    
    func test_coordinator_pushMultiplePages_maintainsOrder() {
        coordinator.push(page: .home)
        coordinator.push(page: .profile(userId: "user_123"))
        
        XCTAssertEqual(coordinator.path.count, 2, "Should show a path count of 2")
        XCTAssertEqual(coordinator.path[0], .home, "First item in path should be 'home'")
        XCTAssertEqual(coordinator.path[1], .profile(userId: "user_123"), "Second item in path should be 'profile' with corresponding userId")
    }
    
    func test_coordinator_deeplink_overwritesExistingPath() {
        coordinator.push(page: .home)
        
        let targetPath: [MockPage] = [.settings, .profile(userId: "deep_link")]
        coordinator.deeplink(targetPath)
        
        XCTAssertEqual(coordinator.path, targetPath, "Deeplink must completely overwrite the existing path stack.")
    }
}
