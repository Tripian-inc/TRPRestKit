//
//  TRPRestKit+Timeline.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Timeline
extension TRPRestKit {
    
    /// Create a Timeline trip with given settings and completion handler parameters.
    ///
    /// Values and meanings of generate attribute in of dayplans; 0=not generated yet, 1=generated and recommended, -1=generated but not recommended.
    ///
    /// - Parameters:
    ///   - settings: TRPTripSettings object that includes settings for the trip.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPTripInfoModel** object. You can only generate trips for next two years.
    public func createTimeline(settings: TRPTimelineSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion
        createOrEditTimelineServices(settings: settings)
    }
    
    /// A services which will be used for both creating and editing services, manages all task connecting to remote server.
    private func createOrEditTimelineServices(settings: TRPTimelineSettings? = nil, segmentSettings: TRPTimelineSegmentSettings? = nil) {
        let timelineService = TRPTimeline(setting: settings, segmentSetting: segmentSettings)
        timelineService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPTimelineModel.self, result, error, pagination)
        }
        timelineService.connection()
    }
    
    /// Create or Update segment with given settings and completion handler parameters. If segmentIndex is nil, it will create a new segment.
    ///
    /// - Parameters:
    ///   - segmentSettings: TRPTimelineSegmentSettings object that includes settings for the updating trip.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPTripInfoModel** object. You can only generate trips for next two years.
    public func createEditTimelineSegment(segmentSettings: TRPTimelineSegmentSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion
        createEditTimelineServices(segmentSettings: segmentSettings)
    }
    
    /// A services which will be used for both creating and editing services, manages all task connecting to remote server.
    private func createEditTimelineServices(segmentSettings: TRPTimelineSegmentSettings) {
        let timelineService = TRPTimelineSegmentAddUpdate(segmentSetting: segmentSettings)
        timelineService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPUpdatedModel.self, result, error, pagination)
        }
        timelineService.connection()
    }
    
    /// Get timeline info with given timeline hash and completion handler parameters.
    ///
    /// - Parameters:
    ///   - hash: A String value that refers to timeline hash.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPTripModel** object.
    public func getTimeline(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getTimelineServices(hash: hash)
    }
    
    /// A services which will be used forgetting trip info services, manages all task connecting to remote server.
    private func getTimelineServices(hash: String) {
        
        let getTimelineService = TRPTimelineGetService(hash: hash)
        getTimelineService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPTimelineModel.self, result, error, pagination)
        }
        getTimelineService.connection()
    }
    
    public func getTimelinePlan(id: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getTimelinePlanServices(planId: id)
    }
    
    /// A services which will be used forgetting trip info services, manages all task connecting to remote server.
    private func getTimelinePlanServices(planId: String, segmentIndex: Int? = nil) {
        
        let getTimelineService = TRPTimelinePlanGetService(planId: planId)
        getTimelineService.completion = { result, error, pagination in
            self.genericParseAndPost([TRPTimelinePlansInfoModel].self, result, error, pagination)
        }
        getTimelineService.connection()
    }
    
    /// Delete timeline  info with given timeline hash  and completion handler parameters.
    ///
    /// - Parameters:
    ///   - hash: A String value that refers to foretold deleting trip hash.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPParentJsonModel** object.
    public func deleteTimeline(hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteTimelineServices(hash: hash)
    }
    
    /// Delete timeline segment info with given timeline hash and segmentIndex and completion handler parameters.
    ///
    /// - Parameters:
    ///   - hash: A String value that refers to foretold deleting trip hash.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPParentJsonModel** object.
    public func deleteTimelineSegment(hash: String, segmentIndex: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteTimelineServices(hash: hash, segmentIndex: segmentIndex)
    }
    
    /// A services which will be used in delete trip services, manages all task connecting to remote server.
    private func deleteTimelineServices(hash: String, segmentIndex: Int? = nil) {
        let deleteService = TRPTimelineDelete(hash: hash, segmentIndex: segmentIndex)
        deleteService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPDeleteUserTripInfo.self, result, error, pagination)
        }
        deleteService.connection()
    }
    
}

