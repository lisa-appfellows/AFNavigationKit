//
//  CoordinatorSheetRouterTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class CoordinatorSheetRouterTests: XCTestCase {
    private var coordinator: Coordinator<DisabledRoute, DisabledRoute, MockSheet>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_coordinator_presentSheet_setsProperty() {
        coordinator.present(sheet: .colorTheme)
        
        XCTAssertEqual(coordinator.sheet, .colorTheme, "Coordinator present(sheet:) should assign 'colorTheme' to sheet property.")
    }
}
