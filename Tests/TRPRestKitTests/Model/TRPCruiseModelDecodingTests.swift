import XCTest
@testable import TRPRestKit

/// The CruiseGenie models decode the payloads the app's own response structs decoded before
/// they moved into the kit, with every optional field absent as well as present.
final class TRPCruiseModelDecodingTests: XCTestCase {

    private let brandJSON = #"{"id": 7, "name": "Royal Caribbean", "logo": "https://cdn/rc.png", "popular": true}"#
    private let portJSON = #"{"id": 312, "name": "Barcelona", "cityId": 41, "lat": 41.38, "lng": 2.17}"#
    private let bareportJSON = #"{"id": 313, "name": "At Sea"}"#

    private var shipItemJSON: String {
        #"{"id": 55, "name": "Wonder of the Seas", "image": "https://cdn/w.png", "brand": \#(brandJSON)}"#
    }

    func testBrandDecodesEveryField() throws {
        let brand = try decode(TRPCruiseBrandModel.self, from: brandJSON)

        XCTAssertEqual(brand.id, 7)
        XCTAssertEqual(brand.name, "Royal Caribbean")
        XCTAssertEqual(brand.logo, "https://cdn/rc.png")
        XCTAssertEqual(brand.popular, true)
    }

    func testBrandWithoutLogoOrPopularDecodes() throws {
        let brand = try decode(TRPCruiseBrandModel.self, from: #"{"id": 7, "name": "Royal Caribbean"}"#)

        XCTAssertNil(brand.logo)
        XCTAssertNil(brand.popular)
    }

    func testShipDecodesEveryField() throws {
        let ship = try decode(TRPCruiseShipModel.self,
                              from: #"{"id": 55, "brandId": 7, "name": "Wonder of the Seas", "logo": "https://cdn/w.png"}"#)

        XCTAssertEqual(ship.id, 55)
        XCTAssertEqual(ship.brandId, 7)
        XCTAssertEqual(ship.name, "Wonder of the Seas")
        XCTAssertEqual(ship.logo, "https://cdn/w.png")
    }

    func testShipWithoutLogoDecodes() throws {
        let ship = try decode(TRPCruiseShipModel.self, from: #"{"id": 55, "brandId": 7, "name": "Wonder of the Seas"}"#)

        XCTAssertNil(ship.logo)
    }

    func testDateDecodes() throws {
        let dates = try decode([TRPCruiseDateModel].self,
                               from: #"[{"date": "2026-10", "name": "October 2026"}, {"date": "2026-11", "name": "November 2026"}]"#)

        XCTAssertEqual(dates.map(\.date), ["2026-10", "2026-11"])
        XCTAssertEqual(dates.first?.name, "October 2026")
    }

    func testCruiseDecodesPortsAndShipWithItsBrand() throws {
        let cruise = try decode(TRPCruiseModel.self, from: """
        {"id": 9001, "name": "Western Med", "roundtrip": true, "manuel": false, "nights": 7,
         "departure": "2026-10-04", "arrival": "2026-10-11",
         "departurePort": \(portJSON), "arrivalPort": \(bareportJSON), "ship": \(shipItemJSON)}
        """)

        XCTAssertEqual(cruise.id, 9001)
        XCTAssertEqual(cruise.name, "Western Med")
        XCTAssertTrue(cruise.roundtrip)
        XCTAssertFalse(cruise.manuel)
        XCTAssertEqual(cruise.nights, 7)
        XCTAssertEqual(cruise.departure, "2026-10-04")
        XCTAssertEqual(cruise.arrival, "2026-10-11")
        XCTAssertEqual(cruise.departurePort.cityId, 41)
        XCTAssertEqual(cruise.arrivalPort.name, "At Sea")
        XCTAssertNil(cruise.arrivalPort.cityId)
        XCTAssertEqual(cruise.ship.name, "Wonder of the Seas")
        XCTAssertEqual(cruise.ship.brand.id, 7)
    }

    func testCruiseOverviewDecodesDaysWithAndWithoutTimes() throws {
        let overview = try decode(TRPCruiseOverviewModel.self, from: """
        {"id": 9001, "name": "Western Med", "staticRouteImage": "https://cdn/route.png",
         "roundtrip": true, "manuel": false, "nights": 7,
         "departure": "2026-10-04", "arrival": "2026-10-11", "ship": \(shipItemJSON),
         "dates": [{"id": 1, "departure": "2026-10-04T17:00:00", "arrival": null, "port": \(portJSON)},
                   {"id": 2, "port": \(bareportJSON)}]}
        """)

        XCTAssertEqual(overview.staticRouteImage, "https://cdn/route.png")
        XCTAssertEqual(overview.dates.count, 2)
        XCTAssertEqual(overview.dates[0].departure, "2026-10-04T17:00:00")
        XCTAssertNil(overview.dates[0].arrival)
        XCTAssertNil(overview.dates[1].departure)
        XCTAssertNil(overview.dates[1].arrival)
        XCTAssertEqual(overview.dates[1].port.id, 313)
    }

    func testPortGroupDecodesPortsWithAndWithoutCity() throws {
        let group = try decode(TRPCruisePortGroupModel.self,
                               from: #"{"continent": "Europe", "ports": [\#(portJSON), \#(bareportJSON)]}"#)

        XCTAssertEqual(group.continent, "Europe")
        XCTAssertEqual(group.ports[0].lat, 41.38)
        XCTAssertEqual(group.ports[0].lng, 2.17)
        XCTAssertNil(group.ports[1].cityId)
        XCTAssertNil(group.ports[1].lat)
        XCTAssertNil(group.ports[1].lng)
    }

    func testPortInfoDecodesWithAndWithoutIconAndSlug() throws {
        let infos = try decode([TRPCruisePortInfoModel].self, from: """
        [{"id": 1, "title": "Currency", "content": "Euro", "icon": "https://cdn/eur.png", "slug": "currency"},
         {"id": 2, "title": "Language", "content": "Catalan, Spanish"}]
        """)

        XCTAssertEqual(infos[0].icon, "https://cdn/eur.png")
        XCTAssertEqual(infos[0].slug, "currency")
        XCTAssertEqual(infos[1].content, "Catalan, Spanish")
        XCTAssertNil(infos[1].icon)
        XCTAssertNil(infos[1].slug)
    }

    private let userShipJSON = """
    {"id": 55, "name": "Wonder of the Seas", "image": "https://cdn/w.png",
     "specifications": {"passengers": "6988", "crew": "2300", "cabins": "2867", "length": "362m",
                        "decksWithCabins": "16", "yearOfBuild": "2022"}}
    """
    private let userBrandJSON = #"{"id": 7, "name": "Royal Caribbean", "logo": "https://cdn/rc.png"}"#

    func testUserCruiseDecodesShipSpecificationsAndBrand() throws {
        let cruise = try decode(TRPUserCruiseModel.self, from: """
        {"id": 42, "name": "Western Med", "departure": "2026-10-04", "arrival": "2026-10-11",
         "hasPreTour": true, "hasPostTour": false, "ship": \(userShipJSON), "brand": \(userBrandJSON),
         "updateRequired": true}
        """)

        XCTAssertEqual(cruise.id, 42)
        XCTAssertTrue(cruise.hasPreTour)
        XCTAssertFalse(cruise.hasPostTour)
        XCTAssertTrue(cruise.updateRequired)
        XCTAssertEqual(cruise.ship.specifications?.yearOfBuild, "2022")
        XCTAssertEqual(cruise.brand.logo, "https://cdn/rc.png")
    }

    func testUserCruiseShipWithoutSpecificationsDecodes() throws {
        let ship = try decode(TRPUserCruiseShipModel.self,
                              from: #"{"id": 55, "name": "Wonder of the Seas", "image": "https://cdn/w.png"}"#)

        XCTAssertNil(ship.specifications)
    }

    func testUserCruiseDetailDecodesDaysAndTours() throws {
        let detail = try decode(TRPUserCruiseDetailModel.self, from: """
        {"id": 42, "name": "Western Med", "departure": "2026-10-04", "arrival": "2026-10-11",
         "staticRouteImage": "https://cdn/route.png", "ship": \(userShipJSON), "brand": \(userBrandJSON),
         "preTour": {"portId": 312, "portName": "Barcelona", "cityId": 41},
         "postTour": {"portId": 312},
         "days": [{"portId": 312, "portName": "Barcelona", "departure": "2026-10-04T17:00:00",
                   "arrival": "2026-10-04T08:00:00", "tripianHash": "hash-1", "trip": true, "cityId": 41,
                   "cityImage": "https://cdn/bcn.png", "tripianHashVersion": "2", "bookablePoi": true,
                   "cityDisplayName": "Barcelona, Spain"},
                  {"portId": 313}]}
        """)

        XCTAssertEqual(detail.id, 42)
        XCTAssertEqual(detail.staticRouteImage, "https://cdn/route.png")
        XCTAssertEqual(detail.preTour?.portName, "Barcelona")
        XCTAssertNil(detail.postTour?.portName)
        XCTAssertEqual(detail.days?.count, 2)

        let port = try XCTUnwrap(detail.days?.first)
        XCTAssertEqual(port.tripianHash, "hash-1")
        XCTAssertEqual(port.trip, true)
        XCTAssertEqual(port.cityId, 41)
        XCTAssertEqual(port.cityImage, "https://cdn/bcn.png")
        XCTAssertEqual(port.tripianHashVersion, "2")
        XCTAssertEqual(port.bookablePoi, true)
        XCTAssertEqual(port.cityDisplayName, "Barcelona, Spain")

        let seaDay = try XCTUnwrap(detail.days?.last)
        XCTAssertEqual(seaDay.portId, 313)
        XCTAssertNil(seaDay.portName)
        XCTAssertNil(seaDay.departure)
        XCTAssertNil(seaDay.arrival)
        XCTAssertNil(seaDay.tripianHash)
        XCTAssertNil(seaDay.trip)
        XCTAssertNil(seaDay.cityId)
        XCTAssertNil(seaDay.cityImage)
        XCTAssertNil(seaDay.tripianHashVersion)
        XCTAssertNil(seaDay.bookablePoi)
        XCTAssertNil(seaDay.cityDisplayName)
    }

    func testUserCruiseDetailWithOnlyAnIdDecodes() throws {
        let detail = try decode(TRPUserCruiseDetailModel.self, from: #"{"id": 42}"#)

        XCTAssertEqual(detail.id, 42)
        XCTAssertNil(detail.name)
        XCTAssertNil(detail.departure)
        XCTAssertNil(detail.arrival)
        XCTAssertNil(detail.staticRouteImage)
        XCTAssertNil(detail.ship)
        XCTAssertNil(detail.brand)
        XCTAssertNil(detail.preTour)
        XCTAssertNil(detail.postTour)
        XCTAssertNil(detail.days)
    }

    func testNotificationDecodesMetadata() throws {
        let notification = try decode(TRPUserNotificationModel.self, from: """
        {"notificationTitle": "Plan ready", "notificationBody": "Barcelona is planned",
         "notificationType": "plan", "metadata": {"cruiseId": 42, "tripHash": "hash-1"},
         "createdAt": "2026-09-01T10:00:00Z", "hasSeen": false}
        """)

        XCTAssertEqual(notification.notificationTitle, "Plan ready")
        XCTAssertEqual(notification.notificationBody, "Barcelona is planned")
        XCTAssertEqual(notification.notificationType, "plan")
        XCTAssertEqual(notification.metadata?.cruiseId, 42)
        XCTAssertEqual(notification.metadata?.tripHash, "hash-1")
        XCTAssertFalse(notification.hasSeen)
    }

    func testNotificationWithOnlyDateAndSeenDecodes() throws {
        let notification = try decode(TRPUserNotificationModel.self,
                                      from: #"{"createdAt": "2026-09-01T10:00:00Z", "hasSeen": true}"#)

        XCTAssertNil(notification.notificationTitle)
        XCTAssertNil(notification.notificationBody)
        XCTAssertNil(notification.notificationType)
        XCTAssertNil(notification.metadata)
        XCTAssertTrue(notification.hasSeen)
    }

    func testNotificationMetadataWithoutFieldsDecodes() throws {
        let metadata = try decode(TRPUserNotificationMetadataModel.self, from: "{}")

        XCTAssertNil(metadata.cruiseId)
        XCTAssertNil(metadata.tripHash)
    }

    func testUnseenNotificationStatusDecodes() throws {
        let status = try decode(TRPUnseenNotificationStatusModel.self, from: #"{"anyUnseenNotification": true}"#)

        XCTAssertTrue(status.anyUnseenNotification)
    }

    func testNotificationSettingDecodesWithAndWithoutDescription() throws {
        let settings = try decode([TRPNotificationSettingModel].self, from: """
        [{"id": 1, "name": "Plans", "description": "When a plan is ready", "checked": true},
         {"id": 2, "name": "Offers", "checked": false}]
        """)

        XCTAssertEqual(settings[0].description, "When a plan is ready")
        XCTAssertTrue(settings[0].checked)
        XCTAssertNil(settings[1].description)
        XCTAssertFalse(settings[1].checked)
    }

    func testTopTenPoisDecodeCategoryAndPois() throws {
        let groups = try decode([TRPTopTenPoisModel].self, from: """
        [{"category": {"id": 3, "name": "Museums"},
          "topTenPoi": [{"id": "poi-1", "cityId": 41, "name": "Picasso Museum",
                         "image": {"url": "https://cdn/pm.png", "width": 800, "height": 600},
                         "gallery": [{"url": "https://cdn/pm2.png"}], "price": 2, "rating": 4.6,
                         "ratingCount": 1200, "description": "Early works", "webUrl": "https://museupicasso.bcn.cat",
                         "phone": "+34 932 56 30 00", "hours": "Tu-Su 10:00-19:00", "address": "Montcada 15",
                         "icon": "museum"},
                        {"id": "poi-2", "cityId": 41, "name": "MACBA", "image": {"url": null}, "icon": "museum"}]}]
        """)

        let group = try XCTUnwrap(groups.first)
        XCTAssertEqual(group.category.id, 3)
        XCTAssertEqual(group.category.name, "Museums")
        XCTAssertEqual(group.topTenPoi.count, 2)

        let full = group.topTenPoi[0]
        XCTAssertEqual(full.id, "poi-1")
        XCTAssertEqual(full.cityId, 41)
        XCTAssertEqual(full.image.url, "https://cdn/pm.png")
        XCTAssertEqual(full.gallery?.first?.url, "https://cdn/pm2.png")
        XCTAssertEqual(full.price, 2)
        XCTAssertEqual(full.rating ?? 0, 4.6, accuracy: 0.001)
        XCTAssertEqual(full.ratingCount, 1200)
        XCTAssertEqual(full.description, "Early works")
        XCTAssertEqual(full.webUrl, "https://museupicasso.bcn.cat")
        XCTAssertEqual(full.phone, "+34 932 56 30 00")
        XCTAssertEqual(full.hours, "Tu-Su 10:00-19:00")
        XCTAssertEqual(full.address, "Montcada 15")
        XCTAssertEqual(full.icon, "museum")

        let bare = group.topTenPoi[1]
        XCTAssertNil(bare.image.url)
        XCTAssertNil(bare.gallery)
        XCTAssertNil(bare.price)
        XCTAssertNil(bare.rating)
        XCTAssertNil(bare.ratingCount)
        XCTAssertNil(bare.description)
        XCTAssertNil(bare.webUrl)
        XCTAssertNil(bare.phone)
        XCTAssertNil(bare.hours)
        XCTAssertNil(bare.address)
    }

    func testFeedbackSubjectsDecodeBothListsOrNeither() throws {
        let subjects = try decode(TRPFeedbackInfoModel.self, from: """
        {"mainSubjects": [{"id": 1, "title": "App", "subjectType": "app"}],
         "poiSubjects": [{"id": 5, "title": "Wrong hours", "subjectType": "poi"}]}
        """)
        let empty = try decode(TRPFeedbackInfoModel.self, from: "{}")

        XCTAssertEqual(subjects.mainSubjects?.first?.title, "App")
        XCTAssertEqual(subjects.poiSubjects?.first?.subjectType, "poi")
        XCTAssertNil(empty.mainSubjects)
        XCTAssertNil(empty.poiSubjects)
    }

    func testUpdateAndCreateResultsDecodeWithAndWithoutTheirField() throws {
        XCTAssertEqual(try decode(TRPUpdateResultModel.self, from: #"{"updated": true}"#).updated, true)
        XCTAssertNil(try decode(TRPUpdateResultModel.self, from: "{}").updated)
        XCTAssertEqual(try decode(TRPCreateResultModel.self, from: #"{"recordId": "rec-1"}"#).recordId, "rec-1")
        XCTAssertNil(try decode(TRPCreateResultModel.self, from: "{}").recordId)
    }

    func testResetPasswordUserDecodes() throws {
        let user = try decode(TRPResetPasswordUserModel.self,
                              from: #"{"id": 12, "firstName": "Ada", "lastName": "Lovelace", "email": "a@b.com"}"#)

        XCTAssertEqual(user.id, 12)
        XCTAssertEqual(user.firstName, "Ada")
        XCTAssertEqual(user.lastName, "Lovelace")
        XCTAssertEqual(user.email, "a@b.com")
    }
}
