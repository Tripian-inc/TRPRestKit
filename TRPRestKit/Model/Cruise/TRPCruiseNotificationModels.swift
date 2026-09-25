//
//  TRPCruiseNotificationModels.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// A notification sent to the user.
public struct TRPUserNotificationModel: Codable {
    public let notificationTitle: String?
    public let notificationBody: String?
    public let notificationType: String?
    public let metadata: TRPUserNotificationMetadataModel?
    public let createdAt: String
    public let hasSeen: Bool
}

/// What a notification points at.
public struct TRPUserNotificationMetadataModel: Codable {
    public let cruiseId: Int?
    public let tripHash: String?
}

public struct TRPUnseenNotificationStatusModel: Codable {
    public let anyUnseenNotification: Bool
}

/// A kind of notification the user can turn on or off.
public struct TRPNotificationSettingModel: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public var checked: Bool
}
