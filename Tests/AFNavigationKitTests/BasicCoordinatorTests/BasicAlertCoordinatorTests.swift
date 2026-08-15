//
//  BasicAlertCoordinatorTests.swift
//  
//
//  Created by Lisa Fellows on 2026-08-14.
//

import XCTest
@testable import AFNavigationKit

final class BasicAlertCoordinatorTests: XCTestCase {
    private var coordinator: BasicCoordinator<DisabledRoute, DisabledRoute, DisabledRoute>!

    private var alertModel: AlertModel {
        let action = Mocks.createAlertAction {}
        return Mocks.createAlertModel(primaryAction: action)
    }
    

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_presentAlert_onNilShouldAssign() {
        let model = alertModel

        coordinator.present(alert: model)

        XCTAssertEqual(coordinator.activeAlert, model, "Should have assigned the model to the activeAlert")
    }

    func test_presentAlert_onActiveShouldQueue() {
        let firstModel = alertModel
        coordinator.present(alert: firstModel)

        XCTAssertEqual(coordinator.activeAlert, firstModel, "Should have assigned the firstModel to the activeAlert")

        let secondModel = alertModel
        coordinator.present(alert: secondModel)

        XCTAssertEqual(coordinator.activeAlert, firstModel, "Presenting secondModel should have queued and left firstModel as active")
        XCTAssertEqual(coordinator.alertQueue, [secondModel], "Should have queued secondModel")
    }

    func test_boundIsPresentedFalse_shouldTriggerClearAlertOnFalse() async throws {
        let model = alertModel
        coordinator.present(alert: model)
        XCTAssertEqual(coordinator.activeAlert, model, "Should have assigned the model to the activeAlert")

        let binding = coordinator.boundIsPresented
        binding.wrappedValue = false

        try await Task.sleep(for: .milliseconds(400))

        XCTAssertNil(coordinator.activeAlert, "Changing binding to false should have set activeAlert to nil")
    }

    func test_boundIsPresentedFalseWithAlertsInQueue_shouldTriggerClearAlertOnFalse() async throws {
        let firstModel = alertModel
        let secondModel = alertModel
        coordinator.present(alert: firstModel)
        coordinator.present(alert: secondModel)
        XCTAssertEqual(coordinator.activeAlert, firstModel, "Should have assigned firstModel")
        XCTAssertEqual(coordinator.alertQueue, [secondModel], "Should have queued secondModel")

        let binding = coordinator.boundIsPresented
        binding.wrappedValue = false

        try await Task.sleep(for: .milliseconds(400))

        XCTAssertEqual(coordinator.activeAlert, secondModel, "Changing binding to false should have cleared firstModel and assigned secondModel")
    }
    
}
