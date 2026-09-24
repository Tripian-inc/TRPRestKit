import XCTest
@testable import TRPRestKit

/// Compares request parameters the way they reach JSON or a query string, so nested device
/// dictionaries and id arrays are compared by value.
func XCTAssertParameters(_ actual: [String: Any]?,
                         _ expected: [String: Any]?,
                         file: StaticString = #filePath,
                         line: UInt = #line) {
    switch (actual, expected) {
    case (nil, nil):
        return
    case let (actual?, expected?):
        XCTAssertEqual(NSDictionary(dictionary: actual), NSDictionary(dictionary: expected), file: file, line: line)
    default:
        XCTFail("Expected \(String(describing: expected)), got \(String(describing: actual))", file: file, line: line)
    }
}

func decode<T: Decodable>(_ type: T.Type, from json: String) throws -> T {
    return try JSONDecoder().decode(T.self, from: Data(json.utf8))
}

enum Fixture {

    static let device = TRPDevice(deviceId: "device-1",
                                  deviceOS: "iOS",
                                  osVersion: "26.5",
                                  bundleId: "com.tripian.CruiseGenie",
                                  firebaseToken: "push-token")

    static let deviceParams: [String: String] = ["deviceId": "device-1",
                                                 "deviceOs": "iOS",
                                                 "osVersion": "26.5",
                                                 "bundleId": "com.tripian.CruiseGenie",
                                                 "serviceToken": "push-token"]
}
