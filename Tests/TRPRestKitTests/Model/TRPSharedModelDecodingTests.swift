import XCTest
@testable import TRPRestKit

/// The shared models gained optional fields for CruiseGenie; payloads other customers get must
/// still decode, and a bad value in a new field must not fail the whole model.
final class TRPSharedModelDecodingTests: XCTestCase {

    private let userWithoutNewFields = """
    {"id": 12, "email": "a@b.com", "firstName": "Ada", "lastName": "Lovelace",
     "dateOfBirth": "1815-12-10", "answers": [1, 2]}
    """

    func testUserWithoutAgeOrProfileImageDecodesThemAsNil() throws {
        let user = try decode(TRPUserInfoModel.self, from: userWithoutNewFields)

        XCTAssertEqual(user.id, 12)
        XCTAssertEqual(user.email, "a@b.com")
        XCTAssertEqual(user.firstName, "Ada")
        XCTAssertEqual(user.lastName, "Lovelace")
        XCTAssertEqual(user.dateOfBirth, "1815-12-10")
        XCTAssertEqual(user.answers, [1, 2])
        XCTAssertNil(user.age)
        XCTAssertNil(user.profileImage)
    }

    func testUserDecodesAgeAndProfileImage() throws {
        let user = try decode(TRPUserInfoModel.self, from: """
        {"id": 12, "email": "a@b.com", "age": 36, "profileImage": "https://cdn/p.png"}
        """)

        XCTAssertEqual(user.age, 36)
        XCTAssertEqual(user.profileImage, "https://cdn/p.png")
    }

    func testUserWithNullAgeAndProfileImageDecodesThemAsNil() throws {
        let user = try decode(TRPUserInfoModel.self, from: """
        {"id": 12, "email": "a@b.com", "age": null, "profileImage": null}
        """)

        XCTAssertNil(user.age)
        XCTAssertNil(user.profileImage)
    }

    func testUserWithWronglyTypedAgeAndProfileImageStillDecodes() throws {
        let user = try decode(TRPUserInfoModel.self, from: """
        {"id": 12, "email": "a@b.com", "firstName": "Ada", "age": "36", "profileImage": 7}
        """)

        XCTAssertEqual(user.id, 12)
        XCTAssertEqual(user.firstName, "Ada")
        XCTAssertNil(user.age)
        XCTAssertNil(user.profileImage)
    }

    private func feedbackJSON(extra: String = "") -> String {
        return """
        {"subject_id": 3, "desc": "Closed", "is_read": false, "subject_type": "poi",
         "created_at": "2026-09-01T10:00:00Z", "poi_id": "poi-1", "trip_hash": "hash-1",
         "replies": []\(extra)}
        """
    }

    func testFeedbackWithoutIdOrSubjectTitleDecodesThemAsNil() throws {
        let feedback = try decode(TRPUserFeedbackInfoModel.self, from: feedbackJSON())

        XCTAssertEqual(feedback.subjectId, 3)
        XCTAssertEqual(feedback.desc, "Closed")
        XCTAssertFalse(feedback.isRead)
        XCTAssertEqual(feedback.subjectType, "poi")
        XCTAssertEqual(feedback.createdAt, "2026-09-01T10:00:00Z")
        XCTAssertEqual(feedback.poiId, "poi-1")
        XCTAssertEqual(feedback.tripHash, "hash-1")
        XCTAssertTrue(feedback.replies.isEmpty)
        XCTAssertNil(feedback.id)
        XCTAssertNil(feedback.subjectTitle)
    }

    func testFeedbackDecodesIdAndSubjectTitle() throws {
        let feedback = try decode(TRPUserFeedbackInfoModel.self,
                                  from: feedbackJSON(extra: #", "id": "fb-9", "subject_title": "Wrong hours""#))

        XCTAssertEqual(feedback.id, "fb-9")
        XCTAssertEqual(feedback.subjectTitle, "Wrong hours")
    }

    func testFeedbackWithWronglyTypedIdAndSubjectTitleStillDecodes() throws {
        let feedback = try decode(TRPUserFeedbackInfoModel.self,
                                  from: feedbackJSON(extra: #", "id": 9, "subject_title": ["x"]"#))

        XCTAssertEqual(feedback.subjectId, 3)
        XCTAssertEqual(feedback.desc, "Closed")
        XCTAssertNil(feedback.id)
        XCTAssertNil(feedback.subjectTitle)
    }

    func testFeedbackListEnvelopeDecodesEveryFeedback() throws {
        let envelope = try decode(TRPUserFeedbackJsonModel.self, from: """
        {"status": 200, "success": true, "data": [\(feedbackJSON(extra: #", "id": "fb-1""#)), \(feedbackJSON())]}
        """)

        XCTAssertEqual(envelope.data?.count, 2)
        XCTAssertEqual(envelope.data?.first?.id, "fb-1")
    }

    func testReplyWithoutIsReadDecodesItAsNil() throws {
        let reply = try decode(TRPUserFeedbackReplyModel.self, from: """
        {"sender": "admin", "reply": "Fixed", "created_at": "2026-09-02T10:00:00Z"}
        """)

        XCTAssertEqual(reply.sender, "admin")
        XCTAssertEqual(reply.reply, "Fixed")
        XCTAssertEqual(reply.createdAt, "2026-09-02T10:00:00Z")
        XCTAssertNil(reply.isRead)
    }

    func testReplyDecodesIsRead() throws {
        let reply = try decode(TRPUserFeedbackReplyModel.self, from: """
        {"sender": "admin", "reply": "Fixed", "created_at": "2026-09-02T10:00:00Z", "is_read": false}
        """)

        XCTAssertEqual(reply.isRead, false)
    }

    func testReplyWithWronglyTypedIsReadStillDecodes() throws {
        let reply = try decode(TRPUserFeedbackReplyModel.self, from: """
        {"sender": "admin", "reply": "Fixed", "created_at": "2026-09-02T10:00:00Z", "is_read": "yes"}
        """)

        XCTAssertEqual(reply.reply, "Fixed")
        XCTAssertNil(reply.isRead)
    }

    func testFeedbackWithRepliesDecodesThem() throws {
        let feedback = try decode(TRPUserFeedbackInfoModel.self, from: """
        {"subject_id": 3, "desc": "Closed", "is_read": true, "subject_type": "poi",
         "created_at": "2026-09-01T10:00:00Z",
         "replies": [{"sender": "admin", "reply": "Fixed", "created_at": "2026-09-02T10:00:00Z", "is_read": 1}]}
        """)

        XCTAssertEqual(feedback.replies.count, 1)
        XCTAssertEqual(feedback.replies.first?.reply, "Fixed")
        XCTAssertNil(feedback.replies.first?.isRead)
    }
}
