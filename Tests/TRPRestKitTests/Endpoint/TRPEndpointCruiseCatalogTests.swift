import XCTest
@testable import TRPRestKit

/// Pins the cruise catalog calls to what CruiseGenie's `CruisesApiRouter` sent: every one is an
/// authorised GET, and an optional filter left nil is not sent.
final class TRPEndpointCruiseCatalogTests: XCTestCase {

    func testBrandsSendsDateAndEveryGivenFilter() {
        let endpoint = TRPEndpoint.cruiseBrands(date: "2026-10", search: "Royal", limit: 20, page: 2)

        XCTAssertEqual(endpoint.path, "cruises/brands")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters, ["date": "2026-10", "search": "Royal", "limit": 20, "page": 2])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testBrandsLeavesOutNilFilters() {
        let endpoint = TRPEndpoint.cruiseBrands(date: "2026-10", search: nil, limit: nil, page: nil)

        XCTAssertParameters(endpoint.queryParameters, ["date": "2026-10"])
    }

    func testBrandsSendsAnEmptySearchAsGiven() {
        let endpoint = TRPEndpoint.cruiseBrands(date: "2026-10", search: "", limit: nil, page: nil)

        XCTAssertParameters(endpoint.queryParameters, ["date": "2026-10", "search": ""])
    }

    func testShipsSendsBrandDateAndEveryGivenFilter() {
        let endpoint = TRPEndpoint.cruiseShips(brandId: 7, date: "2026-10", search: "Wonder", limit: 10, page: 1)

        XCTAssertEqual(endpoint.path, "cruises/ships")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters,
                            ["brandId": 7, "date": "2026-10", "search": "Wonder", "limit": 10, "page": 1])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testShipsLeavesOutNilFilters() {
        let endpoint = TRPEndpoint.cruiseShips(brandId: 7, date: "2026-10", search: nil, limit: nil, page: nil)

        XCTAssertParameters(endpoint.queryParameters, ["brandId": 7, "date": "2026-10"])
    }

    func testDatesIsAnAuthorisedGetWithoutABody() {
        let endpoint = TRPEndpoint.cruiseDates(limit: nil, page: nil)

        XCTAssertEqual(endpoint.path, "cruises/dates")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    /// `CruisesApiRouter.getDates` fell through to `default: return nil`, so the router never sent
    /// paging for it; the endpoint does. The app only calls it with nil paging.
    func testDatesDropsPagingLikeTheRouter() {
        let endpoint = TRPEndpoint.cruiseDates(limit: 12, page: 3)

        XCTExpectFailure("TRPEndpoint.cruiseDates sends limit and page, CruisesApiRouter.getDates did not")
        XCTAssertTrue(endpoint.queryParameters?.isEmpty ?? true)
    }

    func testDatesWithoutPagingSendsNoQueryItems() {
        let endpoint = TRPEndpoint.cruiseDates(limit: nil, page: nil)

        XCTAssertTrue(endpoint.queryParameters?.isEmpty ?? true)
    }

    func testShipDatesSendsBrandAndGivenPaging() {
        let endpoint = TRPEndpoint.cruiseShipDates(brandId: 7, limit: 12, page: 3)

        XCTAssertEqual(endpoint.path, "cruises/ships/dates")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters, ["brandId": 7, "limit": 12, "page": 3])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testShipDatesLeavesOutNilPaging() {
        let endpoint = TRPEndpoint.cruiseShipDates(brandId: 7, limit: nil, page: nil)

        XCTAssertParameters(endpoint.queryParameters, ["brandId": 7])
    }

    func testPortsSendsBrandDateAndEveryGivenFilter() {
        let endpoint = TRPEndpoint.cruisePorts(brandId: 7, date: "2026-10", cityId: 41, search: "Bar", limit: 50, page: 1)

        XCTAssertEqual(endpoint.path, "cruises/ports")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters,
                            ["brandId": 7, "date": "2026-10", "cityId": 41, "search": "Bar", "limit": 50, "page": 1])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testPortsLeavesOutNilFilters() {
        let endpoint = TRPEndpoint.cruisePorts(brandId: 7, date: "2026-10", cityId: nil, search: nil, limit: nil, page: nil)

        XCTAssertParameters(endpoint.queryParameters, ["brandId": 7, "date": "2026-10"])
    }

    func testPortInfoForACitySendsIsCity() {
        let endpoint = TRPEndpoint.cruisePortInfo(portId: 312, isCity: true)

        XCTAssertEqual(endpoint.path, "cruises/port-info/312")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters, ["isCity": 1])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testPortInfoForAPortSendsNoQuery() {
        let endpoint = TRPEndpoint.cruisePortInfo(portId: 312, isCity: false)

        XCTAssertEqual(endpoint.path, "cruises/port-info/312")
        XCTAssertNil(endpoint.queryParameters)
    }

    func testCruisesSendsBrandDatePortAndShip() {
        let endpoint = TRPEndpoint.cruises(brandId: 7, date: "2026-10", portId: 312, shipId: 55)

        XCTAssertEqual(endpoint.path, "cruises/cruises")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters, ["brandId": 7, "date": "2026-10", "portId": 312, "shipId": 55])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testCruisesLeavesOutNilPortAndShip() {
        let endpoint = TRPEndpoint.cruises(brandId: 7, date: "2026-10", portId: nil, shipId: nil)

        XCTAssertParameters(endpoint.queryParameters, ["brandId": 7, "date": "2026-10"])
    }

    func testCruiseOverviewPutsTheCruiseInThePath() {
        let endpoint = TRPEndpoint.cruiseOverview(cruiseId: 9001)

        XCTAssertEqual(endpoint.path, "cruises/cruise-overview/9001")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }
}
