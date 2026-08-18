import XCTest
@testable import AFNavigationKit

final class BasicCoordinatorTests: XCTestCase {
    private var coordinator: BasicCoordinator<MockPage, MockCover, MockSheet>!

    override func setUp() {
        super.setUp()
        coordinator = .init()
    }

    func test_coordinatorFullSetup_hasAssignedAppropriateTypes() {
        coordinator.push(page: .home)
        coordinator.present(cover: .article(slug: "123"))
        coordinator.present(sheet: .colorTheme)

        XCTAssertEqual(coordinator.path.last, MockPage.home, "On push should have assigned as MockPage.home")
        XCTAssertEqual(coordinator.cover, MockCover.article(slug: "123"), "On present(cover:) should have assigned MockCover.article(123)")
        XCTAssertEqual(coordinator.sheet, MockSheet.colorTheme, "On present(sheet:) should have assigned MockSheet.colorTheme")
    }
}
