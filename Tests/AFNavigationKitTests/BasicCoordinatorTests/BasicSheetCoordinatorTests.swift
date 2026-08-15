//
//  BasicSheetCoordinatorTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class BasicSheetCoordinatorTests: XCTestCase {
    private var coordinator: BasicCoordinator<DisabledRoute, DisabledRoute, MockSheet>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_coordinator_presentSheet_setsProperty() {
        coordinator.present(sheet: .colorTheme)
        
        XCTAssertEqual(coordinator.sheet, .colorTheme, "Coordinator present(sheet:) should assign colorTheme to sheet property.")
    }

    func test_dismissSheet_clearsProperty() {
        coordinator.present(sheet: .colorTheme)

        XCTAssertEqual(coordinator.sheet, .colorTheme, "Coordinator present(sheet:) should assign colorTheme to sheet property.")

        coordinator.dismissSheet()

        XCTAssertNil(coordinator.sheet, "Should have set sheet property to nil")
    }
}
