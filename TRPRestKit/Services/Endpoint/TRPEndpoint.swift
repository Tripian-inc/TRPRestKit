//
//  TRPEndpoint.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// A Tripian api call described as data, so it needs no service subclass of its own.
/// `TRPEndpointService` sends it.
internal enum TRPEndpoint {

    case login(email: String, password: String, device: TRPDevice)
    case refreshToken(refreshToken: String, device: TRPDevice)
    case socialLogin(guestToken: String, device: TRPDevice)
    case guestLogin(firstName: String, lastName: String, email: String, password: String, device: TRPDevice)
    case register(firstName: String, lastName: String, email: String, password: String, device: TRPDevice)
    case logout
    case requestPasswordReset(email: String)
    case resetPassword(password: String, hash: String)

    case user
    case updateUser(TRPUserUpdateRequestModel)
    case updateUserImage(profileImage: String)
    case deleteUser

    case cruiseBrands(date: String, search: String?, limit: Int?, page: Int?)
    case cruiseShips(brandId: Int, date: String, search: String?, limit: Int?, page: Int?)
    case cruiseDates(limit: Int?, page: Int?)
    case cruiseShipDates(brandId: Int, limit: Int?, page: Int?)
    case cruisePorts(brandId: Int, date: String, cityId: Int?, search: String?, limit: Int?, page: Int?)
    case cruisePortInfo(portId: Int, isCity: Bool)
    case cruises(brandId: Int, date: String, portId: Int?, shipId: Int?)
    case cruiseOverview(cruiseId: Int)

    case userCruises
    case userCruise(cruiseId: Int)
    case addUserCruise(cruiseId: Int, details: TRPUserCruiseRequestModel)
    case editUserCruise(cruiseId: Int, details: TRPUserCruiseRequestModel)
    case recreateUserCruise(cruiseId: Int, details: TRPUserCruiseRequestModel)
    case deleteUserCruise(cruiseId: Int)
    case deleteUserCruisePlan(tripHash: String)

    case userNotifications
    case unseenNotificationStatus
    case markNotificationsSeen
    case notificationSettings
    case updateNotificationSetting(settingId: Int, checked: Bool)

    case feedbackSubjects
    case userFeedbacks
    case sendFeedback(TRPFeedbackRequestModel)
    case markFeedbackRead(feedbackId: String)
    case replyFeedback(feedbackId: String, reply: String)

    case topTenPois(cityId: Int, poiCategories: [Int]?)

    var path: String {
        typealias Call = TRPConfig.ApiCall
        switch self {
        case .login: return Call.login.link
        case .refreshToken: return Call.refresh.link
        case .socialLogin: return Call.socialLogin.link
        case .guestLogin: return Call.guestLogin.link
        case .register: return Call.register.link
        case .logout: return Call.logout.link
        case .requestPasswordReset, .resetPassword: return Call.resetPassword.link
        case .user, .updateUser, .updateUserImage, .deleteUser: return Call.user.link
        case .cruiseBrands: return "\(Call.cruises.link)/brands"
        case .cruiseShips: return "\(Call.cruises.link)/ships"
        case .cruiseDates: return "\(Call.cruises.link)/dates"
        case .cruiseShipDates: return "\(Call.cruises.link)/ships/dates"
        case .cruisePorts: return "\(Call.cruises.link)/ports"
        case .cruisePortInfo(let portId, _): return "\(Call.cruises.link)/port-info/\(portId)"
        case .cruises, .addUserCruise: return "\(Call.cruises.link)/cruises"
        case .cruiseOverview(let cruiseId): return "\(Call.cruises.link)/cruise-overview/\(cruiseId)"
        case .userCruises: return Call.cruises.link
        case .userCruise(let cruiseId),
             .editUserCruise(let cruiseId, _),
             .deleteUserCruise(let cruiseId): return "\(Call.cruises.link)/\(cruiseId)"
        case .recreateUserCruise(let cruiseId, _): return "\(Call.cruises.link)/\(cruiseId)/recreate"
        case .deleteUserCruisePlan(let tripHash): return "\(Call.cruises.link)/plan/\(tripHash)"
        case .userNotifications: return Call.notifications.link
        case .unseenNotificationStatus, .markNotificationsSeen: return "\(Call.notifications.link)/unseen"
        case .notificationSettings, .updateNotificationSetting: return Call.notificationSettings.link
        case .feedbackSubjects, .sendFeedback: return Call.feedbacks.link
        case .userFeedbacks: return "\(Call.feedbacks.link)/user"
        case .markFeedbackRead(let feedbackId): return "\(Call.feedbacks.link)/\(feedbackId)"
        case .replyFeedback: return Call.feedbackReply.link
        case .topTenPois: return Call.topTenPois.link
        }
    }

    var mode: TRPRequestMode {
        switch self {
        case .login, .refreshToken, .socialLogin, .guestLogin, .register, .logout,
             .requestPasswordReset, .updateUserImage, .addUserCruise, .recreateUserCruise,
             .sendFeedback, .replyFeedback:
            return .post
        case .resetPassword, .updateUser, .editUserCruise, .markNotificationsSeen,
             .updateNotificationSetting, .markFeedbackRead:
            return .put
        case .deleteUser, .deleteUserCruise, .deleteUserCruisePlan:
            return .delete
        default:
            return .get
        }
    }

    /// Login, registration and password reset are made before there is a session to send.
    var requiresAuth: Bool {
        switch self {
        case .login, .guestLogin, .register, .requestPasswordReset, .resetPassword:
            return false
        default:
            return true
        }
    }

    var isRefresh: Bool {
        if case .refreshToken = self { return true }
        return false
    }

    var queryParameters: [String: Any]? {
        switch self {
        case let .cruiseBrands(date, search, limit, page):
            return Self.listing(["date": date], search: search, limit: limit, page: page)
        case let .cruiseShips(brandId, date, search, limit, page):
            return Self.listing(["brandId": brandId, "date": date], search: search, limit: limit, page: page)
        case let .cruiseDates(limit, page):
            return Self.listing([:], search: nil, limit: limit, page: page)
        case let .cruiseShipDates(brandId, limit, page):
            return Self.listing(["brandId": brandId], search: nil, limit: limit, page: page)
        case let .cruisePorts(brandId, date, cityId, search, limit, page):
            var params: [String: Any] = ["brandId": brandId, "date": date]
            params["cityId"] = cityId
            return Self.listing(params, search: search, limit: limit, page: page)
        case let .cruisePortInfo(_, isCity):
            return isCity ? ["isCity": 1] : nil
        case let .cruises(brandId, date, portId, shipId):
            var params: [String: Any] = ["brandId": brandId, "date": date]
            params["portId"] = portId
            params["shipId"] = shipId
            return params
        case let .topTenPois(cityId, poiCategories):
            var params: [String: Any] = ["cityId": cityId]
            params["poiCategories"] = poiCategories?.map(String.init).joined(separator: ",")
            return params
        default:
            return nil
        }
    }

    var bodyParameters: [String: Any]? {
        switch self {
        case let .login(email, password, device):
            return Self.withDevice(["email": email, "password": password], device)
        case let .refreshToken(refreshToken, device):
            return Self.withDevice(["refreshToken": refreshToken], device)
        case let .socialLogin(guestToken, device):
            return Self.withDevice(["guestToken": guestToken], device)
        case let .guestLogin(firstName, lastName, email, password, device),
             let .register(firstName, lastName, email, password, device):
            return Self.withDevice(["firstName": firstName, "lastName": lastName, "email": email, "password": password], device)
        case let .requestPasswordReset(email):
            return ["email": email]
        case let .resetPassword(password, hash):
            return ["password": password, "hash": hash]
        case let .updateUser(request):
            return request.toDictionary()
        case let .updateUserImage(profileImage):
            return ["profileImage": profileImage]
        case let .addUserCruise(cruiseId, details):
            var params = details.toDictionary()
            params["cruiseId"] = cruiseId
            return params
        case let .editUserCruise(_, details), let .recreateUserCruise(_, details):
            return details.toDictionary()
        case let .updateNotificationSetting(settingId, checked):
            return ["settingId": settingId, "checked": checked]
        case let .sendFeedback(request):
            return request.toDictionary()
        case .markFeedbackRead:
            return ["isRead": true]
        case let .replyFeedback(feedbackId, reply):
            return ["reply": reply, "feedbackId": feedbackId]
        default:
            return nil
        }
    }

    private static func listing(_ params: [String: Any], search: String?, limit: Int?, page: Int?) -> [String: Any] {
        var params = params
        params["search"] = search
        params["limit"] = limit
        params["page"] = page
        return params
    }

    private static func withDevice(_ params: [String: Any], _ device: TRPDevice) -> [String: Any] {
        var params = params
        params["device"] = device.params()
        return params
    }
}
