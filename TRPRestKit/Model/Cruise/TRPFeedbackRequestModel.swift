//
//  TRPFeedbackRequestModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// A feedback the user sends about the app, a trip or a poi.
public struct TRPFeedbackRequestModel {

    public var subjectType: String
    public var subjectId: Int
    public var desc: String
    public var tripHash: String?
    public var poiId: String?
    /// Free-form details stored with the feedback as they are given.
    public var data: [String: Any]?
    public var device: TRPDevice

    public init(subjectType: String,
                subjectId: Int,
                desc: String,
                tripHash: String? = nil,
                poiId: String? = nil,
                data: [String: Any]? = nil,
                device: TRPDevice = TRPDevice()) {
        self.subjectType = subjectType
        self.subjectId = subjectId
        self.desc = desc
        self.tripHash = tripHash
        self.poiId = poiId
        self.data = data
        self.device = device
    }

    internal func toDictionary() -> [String: Any] {
        var params: [String: Any] = ["subjectType": subjectType, "subjectId": subjectId, "desc": desc]
        params["device"] = device.params()
        params["data"] = data
        if let tripHash = tripHash, !tripHash.isEmpty {
            params["tripHash"] = tripHash
        }
        params["poiId"] = poiId
        return params
    }
}
