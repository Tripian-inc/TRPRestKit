import XCTest
@testable import TRPRestKit

/// `TRPConfigListModel` decodes a real dev response and survives missing, extra and wrongly typed fields.
final class TRPConfigListModelDecodingTests: XCTestCase {

    private func decodeFixture() throws -> TRPConfigListModel {
        let envelope = try decode(TRPGenericParser<TRPConfigListModel>.self, from: Fixture.configListEnvelope)
        return try XCTUnwrap(envelope.data)
    }

    func testFixtureDecodesTheTourAndTicketProviders() throws {
        let providers = try XCTUnwrap(try decodeFixture().providers?.tourAndTicket)

        XCTAssertEqual(providers.map(\.id), [1, 12, 13])
        XCTAssertEqual(providers.map(\.name), ["viator", "Toristy", "Victory"])
        XCTAssertEqual(providers.map(\.apiUrl), ["https://api.sandbox.viator.com/partner/",
                                                 "https://api.toristy.com",
                                                 "https://api.sandbox.ticketevolution.com"])
        XCTAssertEqual(providers.map(\.prod), [false, true, false])
        XCTAssertEqual(providers.map(\.limit), [50, 50, 50])
        XCTAssertEqual(providers.first?.apiKey, "REDACTED_36")
        XCTAssertEqual(providers.first?.clientId, "")
    }

    func testFixtureDecodesTheOtherProviderGroups() throws {
        let providers = try XCTUnwrap(try decodeFixture().providers)

        XCTAssertEqual(providers.transportation?.map(\.id), [9])
        XCTAssertEqual(providers.transportation?.map(\.name), ["uber"])
        XCTAssertEqual(providers.restaurant?.map(\.id), [5, 2])
        XCTAssertEqual(providers.restaurant?.map(\.name), ["opentable", "yelp"])
        XCTAssertEqual(providers.accommodation?.count, 0)
    }

    func testFixtureDecodesTheRestOfTheConfiguration() throws {
        let config = try decodeFixture()

        XCTAssertEqual(config.apiKey, "REDACTED_32")
        XCTAssertEqual(config.whiteLabels?.brandName, "Cruise Genie")
        XCTAssertEqual(config.whiteLabels?.cookieConsentUrl, "")
        XCTAssertEqual(config.whiteLabels?.languages, ["en", "de", "es"])
        XCTAssertEqual(config.whiteLabels?.cognito?.region, "eu-west-1")
        XCTAssertEqual(config.whiteLabels?.cognito?.identityProviders, ["Google", "SignInWithApple"])
        XCTAssertEqual(config.whiteLabels?.theme?.light?.primary, "#e9314a")
        XCTAssertEqual(config.whiteLabels?.externalMenuLinks, [:])
        XCTAssertEqual(config.baseFeatures?.showRegister, true)
        XCTAssertEqual(config.baseFeatures?.qrReader, "business")
        XCTAssertEqual(config.baseFeatures?.landingPage, "LandingPage")
        XCTAssertEqual(config.sbt?.offerTypes, ["percentage", "amount", "quantity", "spend_for_gift"])
        XCTAssertEqual(config.androidVersionCode, 0)
        XCTAssertEqual(config.aiSupport, false)
    }

    func testPayloadWithoutProvidersDecodes() throws {
        let config = try decode(TRPConfigListModel.self, from: #"{"apiKey": "k", "androidVersionCode": 3}"#)

        XCTAssertNil(config.providers)
        XCTAssertNil(config.whiteLabels)
        XCTAssertEqual(config.apiKey, "k")
        XCTAssertEqual(config.androidVersionCode, 3)
    }

    func testEmptyPayloadDecodes() throws {
        let config = try decode(TRPConfigListModel.self, from: "{}")

        XCTAssertNil(config.apiKey)
        XCTAssertNil(config.providers)
    }

    func testUnknownKeysAreIgnored() throws {
        let json = #"""
        {"newTopLevel": {"a": [1, 2]},
         "providers": {"tourAndTicket": [{"id": 1, "name": "viator", "region": "eu", "extra": {"x": 1}}],
                       "experiences": [{"id": 99}]},
         "whiteLabels": {"brandName": "Cruise Genie", "priorityTourIds": {"1": [4, 5]}, "registerFields": [{"k": "v"}]}}
        """#
        let config = try decode(TRPConfigListModel.self, from: json)

        XCTAssertEqual(config.providers?.tourAndTicket?.first?.id, 1)
        XCTAssertEqual(config.providers?.tourAndTicket?.first?.name, "viator")
        XCTAssertNil(config.providers?.tourAndTicket?.first?.limit)
        XCTAssertNil(config.providers?.transportation)
        XCTAssertEqual(config.whiteLabels?.brandName, "Cruise Genie")
    }

    func testWronglyTypedFieldsDecodeAsNil() throws {
        let json = #"""
        {"apiKey": 42,
         "aiSupport": "yes",
         "providers": {"tourAndTicket": [{"id": "1", "name": "viator", "limit": "fifty", "prod": 1, "apiUrl": null}],
                       "restaurant": "none"},
         "whiteLabels": {"languages": "en", "brandName": "Cruise Genie"}}
        """#
        let config = try decode(TRPConfigListModel.self, from: json)
        let provider = try XCTUnwrap(config.providers?.tourAndTicket?.first)

        XCTAssertNil(config.apiKey)
        XCTAssertNil(config.aiSupport)
        XCTAssertNil(provider.id)
        XCTAssertEqual(provider.name, "viator")
        XCTAssertNil(provider.limit)
        XCTAssertNil(provider.prod)
        XCTAssertNil(provider.apiUrl)
        XCTAssertNil(config.providers?.restaurant)
        XCTAssertNil(config.whiteLabels?.languages)
        XCTAssertEqual(config.whiteLabels?.brandName, "Cruise Genie")
    }

    func testEnvelopeWithoutDataDecodesAsNil() throws {
        let envelope = try decode(TRPGenericParser<TRPConfigListModel>.self,
                                  from: #"{"status": 200, "success": true, "message": "Success"}"#)

        XCTAssertNil(envelope.data)
    }
}
