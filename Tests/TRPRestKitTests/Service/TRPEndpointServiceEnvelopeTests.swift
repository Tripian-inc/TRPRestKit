import XCTest
@testable import TRPRestKit

/// Feeds response envelopes straight into `servicesResult(data:error:)`, the step after the
/// network, and checks what reaches `completion`.
final class TRPEndpointServiceEnvelopeTests: XCTestCase {

    private struct Outcome {
        let result: Any?
        let error: NSError?
        let pagination: Pagination?
    }

    private func deliver<T: Decodable>(_ type: T.Type,
                                       endpoint: TRPEndpoint = .userCruises,
                                       json: String?,
                                       error: NSError? = nil) -> [Outcome] {
        let service = TRPEndpointService<T>(endpoint: endpoint)
        var outcomes: [Outcome] = []
        service.completion = { result, error, pagination in
            outcomes.append(Outcome(result: result, error: error, pagination: pagination))
        }
        service.servicesResult(data: json.map { Data($0.utf8) }, error: error)
        return outcomes
    }

    func testServiceDescribesItsEndpoint() {
        let service = TRPEndpointService<TRPUpdateResultModel>(endpoint: .markFeedbackRead(feedbackId: "fb-9"))

        XCTAssertEqual(service.path(), "feedbacks/fb-9")
        XCTAssertEqual(service.requestMode(), .put)
        XCTAssertNil(service.parameters())
        XCTAssertParameters(service.bodyParameters(), ["isRead": true])
        XCTAssertTrue(service.userOAuth())
        XCTAssertFalse(service.isRefresh)
    }

    func testRefreshServiceIsMarkedAsARefresh() {
        let service = TRPEndpointService<TRPRefreshTokenInfoModel>(endpoint: .refreshToken(refreshToken: "r",
                                                                                           device: Fixture.device))

        XCTAssertTrue(service.isRefresh)
    }

    func testEnvelopeWithDataReachesCompletionDecoded() throws {
        let outcomes = deliver([TRPCruiseBrandModel].self, json: """
        {"status": 200, "success": true, "message": "ok", "data": [{"id": 7, "name": "Royal Caribbean"}]}
        """)

        XCTAssertEqual(outcomes.count, 1)
        let envelope = try XCTUnwrap(outcomes.first?.result as? TRPGenericParser<[TRPCruiseBrandModel]>)
        XCTAssertNil(outcomes.first?.error)
        XCTAssertEqual(envelope.status, 200)
        XCTAssertTrue(envelope.success)
        XCTAssertEqual(envelope.data?.first?.name, "Royal Caribbean")
    }

    func testEnvelopeWithObjectDataReachesCompletionDecoded() throws {
        let outcomes = deliver(TRPUpdateResultModel.self,
                               json: #"{"status": 200, "success": true, "data": {"updated": true}}"#)

        let envelope = try XCTUnwrap(outcomes.first?.result as? TRPGenericParser<TRPUpdateResultModel>)
        XCTAssertEqual(envelope.data?.updated, true)
    }

    func testEnvelopeWithNullDataReachesCompletionWithNilData() throws {
        let outcomes = deliver(TRPUpdateResultModel.self, json: #"{"status": 200, "success": true, "data": null}"#)

        XCTAssertEqual(outcomes.count, 1)
        let envelope = try XCTUnwrap(outcomes.first?.result as? TRPGenericParser<TRPUpdateResultModel>)
        XCTAssertNil(outcomes.first?.error)
        XCTAssertNil(envelope.data)
    }

    func testEnvelopeWithoutDataReachesCompletionWithNilData() throws {
        let outcomes = deliver([TRPUserCruiseModel].self, json: #"{"status": 200, "success": true}"#)

        XCTAssertEqual(outcomes.count, 1)
        let envelope = try XCTUnwrap(outcomes.first?.result as? TRPGenericParser<[TRPUserCruiseModel]>)
        XCTAssertNil(outcomes.first?.error)
        XCTAssertNil(envelope.data)
    }

    func testEnvelopeWithPaginationReportsTheRemainingPages() throws {
        let outcomes = deliver([TRPCruiseBrandModel].self, json: """
        {"status": 200, "success": true, "data": [],
         "pagination": {"count": 0, "total": 40, "perPage": 20, "currentPage": 1, "totalPages": 2, "links": {}}}
        """)

        guard case .continues? = outcomes.first?.pagination else {
            return XCTFail("Expected more pages, got \(String(describing: outcomes.first?.pagination))")
        }
    }

    func testDataOfTheWrongShapeReachesCompletionAsAParserError() {
        let outcomes = deliver([TRPCruiseBrandModel].self,
                               json: #"{"status": 200, "success": true, "data": {"id": 7, "name": "Royal Caribbean"}}"#)

        XCTAssertEqual(outcomes.count, 1)
        XCTAssertNil(outcomes.first?.result)
        XCTAssertEqual(outcomes.first?.error?.domain, TRPErrors.errorDomain)
        XCTAssertTrue(outcomes.first?.error?.localizedDescription.contains("Code: 304") ?? false)
    }

    func testDataMissingARequiredFieldReachesCompletionAsAParserError() {
        let outcomes = deliver(TRPUnseenNotificationStatusModel.self,
                               json: #"{"status": 200, "success": true, "data": {}}"#)

        XCTAssertNil(outcomes.first?.result)
        XCTAssertTrue(outcomes.first?.error?.localizedDescription.contains("Code: 302") ?? false)
    }

    func testEnvelopeWithoutStatusReachesCompletionAsAParserError() {
        let outcomes = deliver(TRPUpdateResultModel.self, json: #"{"success": true, "data": {"updated": true}}"#)

        XCTAssertNil(outcomes.first?.result)
        XCTAssertTrue(outcomes.first?.error?.localizedDescription.contains("Code: 302") ?? false)
    }

    func testBodyThatIsNotJSONReachesCompletionAsAParserError() {
        let outcomes = deliver(TRPUpdateResultModel.self, json: "<html>Bad gateway</html>")

        XCTAssertNil(outcomes.first?.result)
        XCTAssertTrue(outcomes.first?.error?.localizedDescription.contains("Code: 301") ?? false)
    }

    func testMissingBodyReachesCompletionAsWrongData() {
        let outcomes = deliver(TRPUpdateResultModel.self, json: nil)

        XCTAssertEqual(outcomes.count, 1)
        XCTAssertNil(outcomes.first?.result)
        XCTAssertEqual(outcomes.first?.error?.localizedDescription, TRPErrors.wrongData.localizedDescription)
    }

    func testTransportErrorReachesCompletionUnchanged() {
        let transportError = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)
        let outcomes = deliver(TRPUpdateResultModel.self,
                               json: #"{"status": 200, "success": true, "data": {"updated": true}}"#,
                               error: transportError)

        XCTAssertEqual(outcomes.count, 1)
        XCTAssertNil(outcomes.first?.result)
        XCTAssertEqual(outcomes.first?.error, transportError)
    }
}
