import XCTest
@testable import TRPRestKit

/// Pins the platform configuration call to `GET misc/config-list?platform=…`, sent with the api key only.
final class TRPEndpointConfigListTests: XCTestCase {

    func testConfigListIsAnUnauthorisedGetWithThePlatform() {
        let endpoint = TRPEndpoint.configList(platform: "ios")

        XCTAssertEqual(endpoint.path, "misc/config-list")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters, ["platform": "ios"])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertFalse(endpoint.requiresAuth)
        XCTAssertFalse(endpoint.isRefresh)
    }

    func testConfigListSendsTheGivenPlatform() {
        let endpoint = TRPEndpoint.configList(platform: "android")

        XCTAssertParameters(endpoint.queryParameters, ["platform": "android"])
    }

    func testServiceDescribesTheConfigListEndpoint() {
        let service = TRPEndpointService<TRPConfigListModel>(endpoint: .configList(platform: "ios"))

        XCTAssertEqual(service.path(), "misc/config-list")
        XCTAssertEqual(service.requestMode(), .get)
        XCTAssertParameters(service.parameters(), ["platform": "ios"])
        XCTAssertFalse(service.userOAuth())
    }
}
