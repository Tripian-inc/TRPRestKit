//
//  TRPRestKit+PlanSteps.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Update Daily Plan
extension TRPRestKit {
    
    /// Update daily plan hour with given daily plan Id, start time, end time and completion parameters.
    ///
    /// - Parameters:
    ///    - dailyPlanId: An Integer value that refers to the daily plan Id.
    ///    - start: A String value which refers to start time of the daily plan.
    ///    - end: A String value which refers to end time of the daily plan.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPDailyPlanInfoModel** object.
    public func updateDailyPlanHour(dailyPlanId: Int, start: String, end: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        updateDailyPlanService(dailyPlanId: dailyPlanId, start: start, end: end)
    }
    
    /// Update daily plan steps with given daily plan Id, step orders and completion parameters.
    ///
    /// - Parameters:
    ///    - dailyPlanId: An Integer value that refers to the daily plan Id.
    ///    - start: A String value which refers to start time of the daily plan.
    ///    - end: A String value which refers to end time of the daily plan.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPDailyPlanInfoModel** object.
    public func updateDailyPlanStepOrders(dailyPlanId: Int, stepOrders: [Int], completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        updateDailyPlanService(dailyPlanId: dailyPlanId, stepOrders: stepOrders)
    }
    
    /// A services which will be used in daily plan hour services, manages all task connecting to remote server.
    private func updateDailyPlanService(dailyPlanId: Int, start: String? = nil, end: String? = nil, stepOrders: [Int]? = nil) {
        var dailyPlanService = TRPDailyPlanServices(id: dailyPlanId)
        if let start, let end {
            dailyPlanService = TRPDailyPlanServices(id: dailyPlanId, startTime: start, endTime: end)
        }
        if let stepOrders {
            dailyPlanService = TRPDailyPlanServices(id: dailyPlanId, stepOrders: stepOrders)
        }
        dailyPlanService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPDayPlanJsonModel {
                self.postData(result: serviceResult.data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        dailyPlanService.connection()
    }
    
}

// MARK: - Export Daily Plan
extension TRPRestKit {
    
    /// Update daily plan hour with given daily plan Id, start time, end time and completion parameters.
    ///
    /// - Parameters:
    ///    - dailyPlanId: An Integer value that refers to the daily plan Id.
    ///    - start: A String value which refers to start time of the daily plan.
    ///    - end: A String value which refers to end time of the daily plan.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPDailyPlanInfoModel** object.
    public func exportPlanMap(planId: Int, tripHash: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        exportPlanMapService(planId: planId, tripHash: tripHash)
    }
    
    /// A services which will be used in daily plan hour services, manages all task connecting to remote server.
    private func exportPlanMapService(planId: Int, tripHash: String) {
        let exportPlanService = TRPExportPlanServices(planId: planId, tripHash: tripHash)
        exportPlanService.completion = {   (result, error, pagination) in
            self.genericParseAndPost(TRPExportPlanJsonModel.self, result, error, pagination)
        }
        exportPlanService.connection()
    }
    
}

// MARK: - Steps
extension TRPRestKit {
    
    /// Add Plan POI to the daily plan.
    public func addStep(planId: Int, poiId: String, order: Int? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        stepService(planId: planId, poiId: poiId, order: order)
    }
    
    public func addCustomStep(planId: Int, name: String, address: String, description: String, photoUrl: String?, web: String?, latitude: Double?, longitude: Double?, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        customStepService(planId: planId, name: name, address: address, description: description, photoUrl: photoUrl, web: web, latitude: latitude, longitude: longitude)
    }
    
    public func editStep(stepId: Int,
                         poiId: String,
                         completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        stepService(poiId: poiId, stepId: stepId)
    }
    
    public func editStep(stepId: Int,
                         order: Int,
                         completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        stepService(order: order, stepId: stepId)
    }
    
    public func editStep(stepId: Int,
                         startTime: String,
                         endTime: String,
                         completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        stepService(stepId: stepId, startTime: startTime, endTime: endTime)
    }
    
    public func editStep(stepId: Int,
                         poiId: String,
                         order: Int,
                         completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        stepService(poiId: poiId, order: order, stepId: stepId)
    }
    
    public func deleteStep(stepId: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        stepDeleteService(stepId: stepId)
    }
    
    private func stepService(planId: Int? = nil, poiId: String? = nil, order:Int? = nil, stepId: Int? = nil, startTime: String? = nil, endTime: String? = nil) {
        var service: TRPStepServices?
        //Edit Step
        if let step = stepId {
            service = TRPStepServices(stepId: step, poiId: poiId, order: order, startTime: startTime, endTime: endTime)
        }else if let planId = planId, let poiId = poiId { //Add Step In Plan
            service = TRPStepServices(planId: planId, poiId: poiId, order: order)
        }
        guard let stepService = service else {
            print("[Error] StepService mustn't be nil")
            return
        }
        stepService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPStepInfoModel.self, result, error, pagination)
        }
        stepService.connection()
    }
    
    private func customStepService(planId: Int, name: String? = nil, address: String? = nil, description: String? = nil, photoUrl: String? = nil, web: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        let service = TRPCustomStepServices(planId: planId, name: name, address: address, description: description, photoUrl: photoUrl, web: web, latitude: latitude, longitude: longitude)
        service.completion = { result, error, pagination in
            self.genericParseAndPost(TRPStepInfoModel.self, result, error, pagination)
        }
        service.connection()
    }
    
    private func stepDeleteService(stepId: Int) {
        let service = TRPDeleteStepService(stepId: stepId)
        service.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        service.connection()
    }
    
}

// MARK: - Timeline Steps
extension TRPRestKit {
    
    /// Add Plan POI to the daily plan.
    public func addTimelineStep(step: TRPTimelineStepCreateModel,
                                completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        timelineStepService(stepCreate: step)
    }
    
    public func editTimelineStep(step: TRPTimelineStepEditModel,
                                 completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        timelineStepService(stepEdit: step)
    }
    
    public func deleteTimelineStep(stepId: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        timelineStepDeleteService(stepId: stepId)
    }
    
    private func timelineStepService(stepCreate: TRPTimelineStepCreateModel? = nil, stepEdit: TRPTimelineStepEditModel? = nil) {
        var service: TRPTimelineStepServices?
        //Edit Step
        if let stepCreate {
            service = TRPTimelineStepServices(stepModel: stepCreate)
        } else if let stepEdit {
            service = TRPTimelineStepServices(stepModel: stepEdit)
        }
        guard let stepService = service else {
            print("[Error] StepService mustn't be nil")
            return
        }
        stepService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPTimelineStepInfoModel.self, result, error, pagination)
        }
        stepService.connection()
    }
    
    private func timelineStepDeleteService(stepId: Int) {
        let service = TRPDeleteTimelineStepService(stepId: stepId)
        service.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        service.connection()
    }
    
}

