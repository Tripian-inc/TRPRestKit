import XCTest
@testable import TRPRestKit

/// Pins the user's cruise calls to what CruiseGenie's `UserCruiseApiRouter` sent.
final class TRPEndpointUserCruiseTests: XCTestCase {

    private let fullDetails = TRPUserCruiseRequestModel(hasPreTour: 1, hasPostTour: 0,
                                                        numberOfAdults: 2, numberOfChildren: 1,
                                                        companionIds: [11, 12])

    private let fullDetailsParams: [String: Any] = ["hasPreTour": 1, "hasPostTour": 0,
                                                    "numberOfAdults": 2, "numberOfChildren": 1,
                                                    "companionIds": [11, 12]]

    func testUserCruisesIsAnAuthorisedGetOnCruises() {
        let endpoint = TRPEndpoint.userCruises

        XCTAssertEqual(endpoint.path, "cruises")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testUserCruisePutsTheCruiseInThePath() {
        let endpoint = TRPEndpoint.userCruise(cruiseId: 42)

        XCTAssertEqual(endpoint.path, "cruises/42")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testAddUserCruisePostsTheCruiseWithEveryDetail() {
        let endpoint = TRPEndpoint.addUserCruise(cruiseId: 42, details: fullDetails)

        var expected = fullDetailsParams
        expected["cruiseId"] = 42
        XCTAssertEqual(endpoint.path, "cruises/cruises")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, expected)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testAddUserCruiseWithoutDetailsPostsOnlyTheCruise() {
        let endpoint = TRPEndpoint.addUserCruise(cruiseId: 42, details: TRPUserCruiseRequestModel())

        XCTAssertParameters(endpoint.bodyParameters, ["cruiseId": 42])
    }

    func testAddUserCruiseLeavesOutEachNilDetail() {
        let details = TRPUserCruiseRequestModel(hasPreTour: 1, numberOfChildren: 0)
        let endpoint = TRPEndpoint.addUserCruise(cruiseId: 42, details: details)

        XCTAssertParameters(endpoint.bodyParameters, ["cruiseId": 42, "hasPreTour": 1, "numberOfChildren": 0])
    }

    func testEditUserCruisePutsEveryDetailWithoutTheCruiseInTheBody() {
        let endpoint = TRPEndpoint.editUserCruise(cruiseId: 42, details: fullDetails)

        XCTAssertEqual(endpoint.path, "cruises/42")
        XCTAssertEqual(endpoint.mode, .put)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, fullDetailsParams)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testEditUserCruiseSendsAnEmptyCompanionList() {
        let details = TRPUserCruiseRequestModel(hasPreTour: 0, hasPostTour: 0, numberOfAdults: 1,
                                                numberOfChildren: 0, companionIds: [])
        let endpoint = TRPEndpoint.editUserCruise(cruiseId: 42, details: details)

        XCTAssertParameters(endpoint.bodyParameters,
                            ["hasPreTour": 0, "hasPostTour": 0, "numberOfAdults": 1,
                             "numberOfChildren": 0, "companionIds": [Int]()])
    }

    func testRecreateUserCruisePostsEveryDetailToRecreate() {
        let endpoint = TRPEndpoint.recreateUserCruise(cruiseId: 42, details: fullDetails)

        XCTAssertEqual(endpoint.path, "cruises/42/recreate")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, fullDetailsParams)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testDeleteUserCruiseIsADeleteOnTheCruise() {
        let endpoint = TRPEndpoint.deleteUserCruise(cruiseId: 42)

        XCTAssertEqual(endpoint.path, "cruises/42")
        XCTAssertEqual(endpoint.mode, .delete)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testDeleteUserCruisePlanIsADeleteOnThePlanHash() {
        let endpoint = TRPEndpoint.deleteUserCruisePlan(tripHash: "abc123")

        XCTAssertEqual(endpoint.path, "cruises/plan/abc123")
        XCTAssertEqual(endpoint.mode, .delete)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }
}
