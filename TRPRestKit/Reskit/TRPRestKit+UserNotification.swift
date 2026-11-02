//
//  TRPRestKit+UserNotification.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - Notifications
extension TRPRestKit {

    public func userNotifications(completion: @escaping ResultHandler<[TRPUserNotificationModel]>) {
        send(.userNotifications, completion: completion)
    }

    public func unseenNotificationStatus(completion: @escaping ResultHandler<TRPUnseenNotificationStatusModel>) {
        send(.unseenNotificationStatus, completion: completion)
    }

    public func markNotificationsSeen(completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.markNotificationsSeen, completion: completion)
    }
}

// MARK: - Notification settings
extension TRPRestKit {

    public func notificationSettings(completion: @escaping ResultHandler<[TRPNotificationSettingModel]>) {
        send(.notificationSettings, completion: completion)
    }

    public func updateNotificationSetting(settingId: Int,
                                          checked: Bool,
                                          completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.updateNotificationSetting(settingId: settingId, checked: checked), completion: completion)
    }
}
