import XCTest
@testable import TRPRestKit

final class TRPRequestModelTests: XCTestCase {

    private let deviceTimeZone = TimeZone.current.identifier

    func testUserUpdateSendsEveryFilledField() {
        let request = TRPUserUpdateRequestModel(firstName: "Ada", lastName: "Lovelace", password: "new",
                                                currentPassword: "old", dateOfBirth: "1815-12-10", answers: [4])

        XCTAssertParameters(request.toDictionary(),
                            ["firstName": "Ada", "lastName": "Lovelace", "password": "new",
                             "currentPassword": "old", "dateOfBirth": "1815-12-10",
                             "answers": [4], "timezone": deviceTimeZone])
    }

    func testUserUpdateLeavesOutEmptyStrings() {
        let request = TRPUserUpdateRequestModel(firstName: "", lastName: "Lovelace", password: "",
                                                currentPassword: "", dateOfBirth: "")

        XCTAssertParameters(request.toDictionary(), ["lastName": "Lovelace", "timezone": deviceTimeZone])
    }

    func testUserUpdateLeavesOutNilFieldsButAlwaysSendsTheTimeZone() {
        XCTAssertParameters(TRPUserUpdateRequestModel().toDictionary(), ["timezone": deviceTimeZone])
    }

    func testUserUpdateSendsAnEmptyAnswerList() {
        let request = TRPUserUpdateRequestModel(answers: [])

        XCTAssertParameters(request.toDictionary(), ["answers": [Int](), "timezone": deviceTimeZone])
    }

    func testUserCruiseSendsEveryGivenDetail() {
        let request = TRPUserCruiseRequestModel(hasPreTour: 1, hasPostTour: 1, numberOfAdults: 2,
                                                numberOfChildren: 3, companionIds: [7])

        XCTAssertParameters(request.toDictionary(),
                            ["hasPreTour": 1, "hasPostTour": 1, "numberOfAdults": 2,
                             "numberOfChildren": 3, "companionIds": [7]])
    }

    func testUserCruiseLeavesOutNilDetails() {
        XCTAssertParameters(TRPUserCruiseRequestModel().toDictionary(), [:])
        XCTAssertParameters(TRPUserCruiseRequestModel(hasPostTour: 0).toDictionary(), ["hasPostTour": 0])
    }

    func testFeedbackIncludesTheDeviceParameters() {
        let request = TRPFeedbackRequestModel(subjectType: "app", subjectId: 1, desc: "Nice", device: Fixture.device)

        XCTAssertParameters(request.toDictionary(),
                            ["subjectType": "app", "subjectId": 1, "desc": "Nice", "device": Fixture.deviceParams])
    }

    func testFeedbackLeavesOutAnEmptyTripHash() {
        let request = TRPFeedbackRequestModel(subjectType: "trip", subjectId: 2, desc: "Late",
                                              tripHash: "", device: Fixture.device)

        XCTAssertNil(request.toDictionary()["tripHash"])
    }

    func testFeedbackSendsAGivenTripHash() {
        let request = TRPFeedbackRequestModel(subjectType: "trip", subjectId: 2, desc: "Late",
                                              tripHash: "hash-1", device: Fixture.device)

        XCTAssertEqual(request.toDictionary()["tripHash"] as? String, "hash-1")
    }

    func testFeedbackLeavesOutANilPoi() {
        let request = TRPFeedbackRequestModel(subjectType: "poi", subjectId: 3, desc: "Closed",
                                              poiId: nil, device: Fixture.device)

        XCTAssertNil(request.toDictionary()["poiId"])
    }

    func testFeedbackSendsAnEmptyPoiAsGiven() {
        let request = TRPFeedbackRequestModel(subjectType: "poi", subjectId: 3, desc: "Closed",
                                              poiId: "", device: Fixture.device)

        XCTAssertEqual(request.toDictionary()["poiId"] as? String, "")
    }

    func testFeedbackSendsDataAsGiven() {
        let request = TRPFeedbackRequestModel(subjectType: "poi", subjectId: 3, desc: "Closed",
                                              data: ["reason": "hours", "tags": [1, 2]], device: Fixture.device)

        XCTAssertParameters(request.toDictionary()["data"] as? [String: Any], ["reason": "hours", "tags": [1, 2]])
    }
}
