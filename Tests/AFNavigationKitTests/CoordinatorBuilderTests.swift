//
//  CoordinatorBuilderTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-13.
//

import XCTest
@testable import AFNavigationKit

final class CoordinatorBuilderTests: XCTestCase {
    func test_defaultInitialization_resolvesToAllDisabled() {
        let sut = NewCoordinator()
            .build()

        let verifiedInstance: Coordinator<DisabledRoute, DisabledRoute, DisabledRoute> = sut
        XCTAssertNotNil(verifiedInstance, "Should resolved to all disabled routes.")
    }

    func test_singleSlotAssignment_mutatesTargetSlotAndLeavesOthers() {
        let sut = NewCoordinator()
            .addPageRouting(MockPageRoute.self)
            .build()

        let verifiedInstance: Coordinator<MockPageRoute, DisabledRoute, DisabledRoute> = sut
        XCTAssertNotNil(verifiedInstance, "Should resolve to a concrete page route.")
    }

    func test_mixMatchAssignment_resolvesToCorrectGenericSignature() {
        let sut = NewCoordinator()
            .addFullscreenRouting(MockFullscreenRoute.self)
            .addSheetRouting(MockSheetRoute.self)
            .build()

        let verifiedInstance: Coordinator<DisabledRoute, MockFullscreenRoute, MockSheetRoute> = sut
        XCTAssertNotNil(verifiedInstance, "Should resolve to concrete fullscreen and sheet routes.")
    }

    func test_configurationOrder_doesNotAffectFinalGenericSignature() {
        let sut = NewCoordinator()
            .addFullscreenRouting(MockFullscreenRoute.self)
            .addPageRouting(MockPageRoute.self)
            .addSheetRouting(MockSheetRoute.self)
            .build()

        let verifiedInstance: Coordinator<MockPageRoute, MockFullscreenRoute, MockSheetRoute> = sut
        XCTAssertNotNil(verifiedInstance, "Should resolve to concrete page, fullscreen, and sheet routes.")
    }
}
