import XCTest
@testable import TRPRestKit

/// Pins the notification, notification setting, feedback and top ten calls to what CruiseGenie's
/// `NotificationApiRouter`, `UserSettingsApiRouter`, `FeedbackRouter` and `PoiApiRouter` sent.
final class TRPEndpointNotificationFeedbackPoiTests: XCTestCase {

    func testUserNotificationsIsAnAuthorisedGet() {
        let endpoint = TRPEndpoint.userNotifications

        XCTAssertEqual(endpoint.path, "notifications")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testUnseenNotificationStatusIsAGetOnUnseen() {
        let endpoint = TRPEndpoint.unseenNotificationStatus

        XCTAssertEqual(endpoint.path, "notifications/unseen")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testMarkNotificationsSeenIsAPutOnUnseenWithoutABody() {
        let endpoint = TRPEndpoint.markNotificationsSeen

        XCTAssertEqual(endpoint.path, "notifications/unseen")
        XCTAssertEqual(endpoint.mode, .put)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testNotificationSettingsIsAnAuthorisedGet() {
        let endpoint = TRPEndpoint.notificationSettings

        XCTAssertEqual(endpoint.path, "notification/settings")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testUpdateNotificationSettingPutsTheSettingAndItsValue() {
        let endpoint = TRPEndpoint.updateNotificationSetting(settingId: 3, checked: false)

        XCTAssertEqual(endpoint.path, "notification/settings")
        XCTAssertEqual(endpoint.mode, .put)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, ["settingId": 3, "checked": false])
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testFeedbackSubjectsIsAnAuthorisedGet() {
        let endpoint = TRPEndpoint.feedbackSubjects

        XCTAssertEqual(endpoint.path, "feedbacks")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testUserFeedbacksIsAGetOnUser() {
        let endpoint = TRPEndpoint.userFeedbacks

        XCTAssertEqual(endpoint.path, "feedbacks/user")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testSendFeedbackPostsEveryGivenField() {
        let request = TRPFeedbackRequestModel(subjectType: "poi", subjectId: 5, desc: "Closed",
                                              tripHash: "hash-1", poiId: "poi-1",
                                              data: ["rating": 2], device: Fixture.device)
        let endpoint = TRPEndpoint.sendFeedback(request)

        XCTAssertEqual(endpoint.path, "feedbacks")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["subjectType": "poi", "subjectId": 5, "desc": "Closed",
                             "tripHash": "hash-1", "poiId": "poi-1", "data": ["rating": 2],
                             "device": Fixture.deviceParams])
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testSendFeedbackLeavesOutMissingOptionalFields() {
        let request = TRPFeedbackRequestModel(subjectType: "app", subjectId: 1, desc: "Nice",
                                              tripHash: "", poiId: nil, data: nil, device: Fixture.device)
        let endpoint = TRPEndpoint.sendFeedback(request)

        XCTAssertParameters(endpoint.bodyParameters,
                            ["subjectType": "app", "subjectId": 1, "desc": "Nice",
                             "device": Fixture.deviceParams])
    }

    func testMarkFeedbackReadPutsIsReadOnTheFeedback() {
        let endpoint = TRPEndpoint.markFeedbackRead(feedbackId: "fb-9")

        XCTAssertEqual(endpoint.path, "feedbacks/fb-9")
        XCTAssertEqual(endpoint.mode, .put)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, ["isRead": true])
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testReplyFeedbackPostsReplyAndFeedback() {
        let endpoint = TRPEndpoint.replyFeedback(feedbackId: "fb-9", reply: "Thanks")

        XCTAssertEqual(endpoint.path, "feedback/reply")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, ["reply": "Thanks", "feedbackId": "fb-9"])
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testTopTenPoisSendsCityAndCommaSeparatedCategories() {
        let endpoint = TRPEndpoint.topTenPois(cityId: 41, poiCategories: [3, 14, 15])

        XCTAssertEqual(endpoint.path, "top10-pois")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertParameters(endpoint.queryParameters, ["cityId": 41, "poiCategories": "3,14,15"])
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testTopTenPoisLeavesOutNilCategories() {
        let endpoint = TRPEndpoint.topTenPois(cityId: 41, poiCategories: nil)

        XCTAssertParameters(endpoint.queryParameters, ["cityId": 41])
    }

    func testTopTenPoisSendsAnEmptyCategoryListAsAnEmptyString() {
        let endpoint = TRPEndpoint.topTenPois(cityId: 41, poiCategories: [])

        XCTAssertParameters(endpoint.queryParameters, ["cityId": 41, "poiCategories": ""])
    }
}
