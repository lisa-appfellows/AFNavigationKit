import SwiftUI
import XCTest
@testable import AFNavigationKit

typealias PageCoord = Coordinator<MockRoute, DisabledRoute, DisabledRoute>
typealias FullscreenCoord = Coordinator<DisabledRoute, MockRoute, DisabledRoute>
typealias SheetCoord = Coordinator<DisabledRoute, DisabledRoute, MockRoute>

enum MockRoute: ValidRoute {
    case home
    case profile(userId: String)
    case settings

    var id: String {
        switch self {
        case .home:
            return "home"
        case .profile(let userId):
            return "profile_\(userId)"
        case .settings:
            return "settings"
        }
    }
}


struct MockFactory: RouteFactory {
    @ViewBuilder
    static func createView(for route: MockRoute) -> some View {
        switch route {
        case .home: Text("Home")
        case .profile: Text("Profile")
        case .settings: Text("Settings")
        }
    }
}

final class AFNavigationKitTests: XCTestCase {
    func test_coordinator_pushPage_appendsToPath() {
        let coordinator = PageCoord()
        
        coordinator.push(page: .home)
        
        XCTAssertEqual(coordinator.path.count, 1, "Pushed page to coordinator should show path count of 1")
        XCTAssertEqual(coordinator.path.last, .home, "Pushed home page to coordinator should show last item in path as 'home'")
    }
    
    func test_coordinator_pushMultiplePages_maintainsOrder() {
        let coordinator = PageCoord()
        
        coordinator.push(page: .home)
        coordinator.push(page: .profile(userId: "user_123"))
        
        XCTAssertEqual(coordinator.path.count, 2, "Should show a path count of 2")
        XCTAssertEqual(coordinator.path[0], .home, "First item in path should be 'home'")
        XCTAssertEqual(coordinator.path[1], .profile(userId: "user_123"), "Second item in path should be 'profile' with corresponding userId")
    }
    
    func test_coordinator_deeplink_overwritesExistingPath() {
        let coordinator = PageCoord()
        coordinator.push(page: .home)
        
        let targetPath: [MockRoute] = [.settings, .profile(userId: "deep_link")]
        coordinator.deeplink(targetPath)
        
        XCTAssertEqual(coordinator.path, targetPath, "Deeplink must completely overwrite the existing path stack.")
    }

    func test_coordinator_pop_removesLastRoute() {
        let coordinator = PageCoord()
        coordinator.deeplink([.home, .settings])

        XCTAssertEqual(coordinator.path, [.home, .settings], "Deeplink should have set path to 'home' and 'settings'")
    
        coordinator.pop()
    
        XCTAssertEqual(coordinator.path, [.home], "Pop should have removed the last route, which was 'settings'")
    }

    func test_coordinator_popToRoot_clearsPath() {
        let coordinator = PageCoord()
        coordinator.deeplink([.home, .settings])

        XCTAssertEqual(coordinator.path, [.home, .settings], "Deeplink should have set path to 'home' and 'settings'")
    
        coordinator.popToRoot()
    
        XCTAssertEqual(coordinator.path, [], "Pop should have cleared the path")
    }
    
    func test_coordinator_presentFullscreen_setsProperty() {
        let coordinator = FullscreenCoord()
        
        coordinator.present(fullscreen: .home)
        
        XCTAssertEqual(coordinator.fullscreen, .home, "Coordinator present(fullscreen:) should assign 'home' to fullscreen property.")
    }

    func test_coordinator_dismissFullscreen_setsPropertyToNil() {
        let coordinator = FullscreenCoord()
        coordinator.present(fullscreen: .home)
        
        XCTAssertEqual(coordinator.fullscreen, .home, "Coordinator present(fullscreen:) should assign 'home' to fullscreen property.")

        coordinator.dismissFullscreen()

        XCTAssertNil(coordinator.fullscreen, "Dismissal should have cleared fullscreen property and set to nil")
    }
    
    func test_coordinator_presentSheet_setsProperty() {
        let coordinator = SheetCoord()
        
        coordinator.present(sheet: .settings)
        
        XCTAssertEqual(coordinator.sheet, .settings, "Coordinator present(sheet:) should assign 'setting' to sheet property.")
    }

    func test_coordinator_dismissSheet_setsPropertyToNil() {
        let coordinator = SheetCoord()
        coordinator.present(sheet: .home)
        
        XCTAssertEqual(coordinator.sheet, .home, "Coordinator present(sheet:) should assign 'home' to sheet property.")

        coordinator.dismissSheet()

        XCTAssertNil(coordinator.sheet, "Dismissal should have cleared sheet property and set to nil")
    }

    func test_coordinator_dismissAll_setsFullscreenAndSheetToNil() {
        let coordinator = Coordinator<MockRoute, MockRoute, MockRoute>()
        coordinator.present(sheet: .home)
        coordinator.present(fullscreen: .settings)

        XCTAssertEqual(coordinator.sheet, .home, "Sheet should have been set to 'home")
        XCTAssertEqual(coordinator.fullscreen, .settings, "Fullscreen should have been set to 'settings")

        coordinator.dismissAll()

        XCTAssertNil(coordinator.sheet, "DismissAll should have cleared sheet and set to nil")
        XCTAssertNil(coordinator.fullscreen, "DismissAll should have cleared fullscreen and set to nil")
    }

    func test_factory_returnsConfiguredSwiftUIView() {
        let view = MockFactory.createView(for: .home)
        XCTAssertNotNil(view, "The factory must compile and return a valid structural SwiftUI layout output.")
    }
}
