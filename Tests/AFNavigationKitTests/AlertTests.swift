//
//  AlertTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class AlertTests: XCTestCase {
    func test_alertActions() {
        var primaryExecuted = false
        var secondaryExecuted = false

        let primaryAction = AlertAction(title: "Primary Action", role: .none) {
            primaryExecuted = true
        }

        let secondaryAction = AlertAction(title: "Secondary Action", role: .none) {
            secondaryExecuted = true
        }

        let alert = AlertContext(
            title: "Mock Alert",
            message: "This is a mock alert",
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )

        alert.primaryAction.action()
        alert.secondaryAction?.action()

        XCTAssertTrue(primaryExecuted, "Calling .primaryAction.action should have set primaryExecuted to true")
        XCTAssertTrue(secondaryExecuted, "Calling .secondaryAction.action should have set secondaryExecuted to true")
    }
}
