import XCTest
@testable import TRPRestKit

/// Pins the account calls to what CruiseGenie's `LoginApiRouter` and `UsersApiRouter` sent.
final class TRPEndpointAccountTests: XCTestCase {

    private let deviceTimeZone = TimeZone.current.identifier

    func testLoginPostsCredentialsAndDevice() {
        let endpoint = TRPEndpoint.login(email: "a@b.com", password: "secret", device: Fixture.device)

        XCTAssertEqual(endpoint.path, "auth/login")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["email": "a@b.com", "password": "secret", "device": Fixture.deviceParams])
        XCTAssertFalse(endpoint.requiresAuth)
        XCTAssertFalse(endpoint.isRefresh)
    }

    func testRefreshTokenPostsRefreshTokenAndDeviceAsARefresh() {
        let endpoint = TRPEndpoint.refreshToken(refreshToken: "refresh-1", device: Fixture.device)

        XCTAssertEqual(endpoint.path, "auth/refresh-token")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["refreshToken": "refresh-1", "device": Fixture.deviceParams])
        XCTAssertTrue(endpoint.requiresAuth)
        XCTAssertTrue(endpoint.isRefresh)
    }

    func testSocialLoginPostsGuestTokenAndDevice() {
        let endpoint = TRPEndpoint.socialLogin(guestToken: "guest-1", device: Fixture.device)

        XCTAssertEqual(endpoint.path, "auth/login-social")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["guestToken": "guest-1", "device": Fixture.deviceParams])
        XCTAssertFalse(endpoint.isRefresh)
    }

    func testGuestLoginPostsNameCredentialsAndDeviceWithoutASession() {
        let endpoint = TRPEndpoint.guestLogin(firstName: "Ada", lastName: "Lovelace",
                                              email: "a@b.com", password: "secret", device: Fixture.device)

        XCTAssertEqual(endpoint.path, "auth/guest-login")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["firstName": "Ada", "lastName": "Lovelace", "email": "a@b.com",
                             "password": "secret", "device": Fixture.deviceParams])
        XCTAssertFalse(endpoint.requiresAuth)
    }

    func testRegisterPostsNameCredentialsAndDeviceWithoutASession() {
        let endpoint = TRPEndpoint.register(firstName: "Ada", lastName: "Lovelace",
                                            email: "a@b.com", password: "secret", device: Fixture.device)

        XCTAssertEqual(endpoint.path, "auth/register")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["firstName": "Ada", "lastName": "Lovelace", "email": "a@b.com",
                             "password": "secret", "device": Fixture.deviceParams])
        XCTAssertFalse(endpoint.requiresAuth)
    }

    func testDeviceWithoutOptionalFieldsSendsOnlyIdAndOs() {
        let device = TRPDevice(deviceId: "device-2", firebaseToken: "")
        let endpoint = TRPEndpoint.login(email: "a@b.com", password: "secret", device: device)

        XCTAssertParameters(endpoint.bodyParameters,
                            ["email": "a@b.com", "password": "secret",
                             "device": ["deviceId": "device-2", "deviceOs": "iOS"]])
    }

    func testLogoutPostsWithoutParameters() {
        let endpoint = TRPEndpoint.logout

        XCTAssertEqual(endpoint.path, "auth/logout")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testRequestPasswordResetPostsEmailWithoutASession() {
        let endpoint = TRPEndpoint.requestPasswordReset(email: "a@b.com")

        XCTAssertEqual(endpoint.path, "auth/reset-password")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, ["email": "a@b.com"])
        XCTAssertFalse(endpoint.requiresAuth)
    }

    func testResetPasswordPutsPasswordAndHashWithoutASession() {
        let endpoint = TRPEndpoint.resetPassword(password: "new-secret", hash: "hash-1")

        XCTAssertEqual(endpoint.path, "auth/reset-password")
        XCTAssertEqual(endpoint.mode, .put)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, ["password": "new-secret", "hash": "hash-1"])
        XCTAssertFalse(endpoint.requiresAuth)
    }

    func testUserIsAnAuthorisedGetWithoutParameters() {
        let endpoint = TRPEndpoint.user

        XCTAssertEqual(endpoint.path, "user")
        XCTAssertEqual(endpoint.mode, .get)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testUpdateUserPutsEveryFilledFieldAndTheTimeZone() {
        let request = TRPUserUpdateRequestModel(firstName: "Ada", lastName: "Lovelace", password: "new",
                                                currentPassword: "old", dateOfBirth: "1815-12-10", answers: [1, 2])
        let endpoint = TRPEndpoint.updateUser(request)

        XCTAssertEqual(endpoint.path, "user")
        XCTAssertEqual(endpoint.mode, .put)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters,
                            ["firstName": "Ada", "lastName": "Lovelace", "password": "new",
                             "currentPassword": "old", "dateOfBirth": "1815-12-10",
                             "answers": [1, 2], "timezone": deviceTimeZone])
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testUpdateUserWithNothingFilledSendsOnlyTheTimeZone() {
        let endpoint = TRPEndpoint.updateUser(TRPUserUpdateRequestModel())

        XCTAssertParameters(endpoint.bodyParameters, ["timezone": deviceTimeZone])
    }

    func testUpdateUserImagePostsTheImage() {
        let endpoint = TRPEndpoint.updateUserImage(profileImage: "data:image/png;base64,AAAA/BB+")

        XCTAssertEqual(endpoint.path, "user")
        XCTAssertEqual(endpoint.mode, .post)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertParameters(endpoint.bodyParameters, ["profileImage": "data:image/png;base64,AAAA/BB+"])
        XCTAssertTrue(endpoint.requiresAuth)
    }

    func testDeleteUserIsADeleteWithoutParameters() {
        let endpoint = TRPEndpoint.deleteUser

        XCTAssertEqual(endpoint.path, "user")
        XCTAssertEqual(endpoint.mode, .delete)
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertNil(endpoint.bodyParameters)
        XCTAssertTrue(endpoint.requiresAuth)
    }
}
