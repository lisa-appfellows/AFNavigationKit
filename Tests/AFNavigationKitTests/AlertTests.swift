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
        
        let primary = Mocks.createAlertAction {
            primaryExecuted = true
        }

        let secondary = Mocks.createAlertAction {
            secondaryExecuted = true
        }

        let alert = Mocks.createAlertModel(primaryAction: primary, secondaryAction: secondary)

        alert.primaryAction.action()
        alert.secondaryAction?.action()

        XCTAssertTrue(primaryExecuted, "Calling .primaryAction.action should have set primaryExecuted to true")
        XCTAssertTrue(secondaryExecuted, "Calling .secondaryAction.action should have set secondaryExecuted to true")
    }

    func test_alertModels_areEqualByIdentity() {
        let action = Mocks.createAlertAction {}
        let first = Mocks.createAlertModel(primaryAction: action)
        let second = Mocks.createAlertModel(primaryAction: action)

        XCTAssertEqual(first, first, "An alert should be equal to itself")
        XCTAssertNotEqual(first, second, "Newly constructed alerts should have unique ids")
    }
}
