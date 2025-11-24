//
//  TRPStepServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 5.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation

final class TRPTimelineStepServices: TRPRestServices<TRPGenericParser<TRPTimelineStepInfoModel>> {
    
    enum ServiceType {
        case edit, add
    }
    
    private var stepCreateModel: TRPTimelineStepCreateModel?
    private var stepEditModel: TRPTimelineStepEditModel?
    private let serviceType: ServiceType
    
    //Add Step
    init(stepModel: TRPTimelineStepCreateModel?) {
        serviceType = .add
        self.stepCreateModel = stepModel
    }
    
    //Edit Step
    init(stepModel: TRPTimelineStepEditModel?) {
        self.stepEditModel = stepModel
        serviceType = .edit
    }
    
    override func requestMode() -> TRPRequestMode {
        if serviceType == .add {
            return .post
        }
        return .put
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    override func bodyParameters() -> [String: Any]? {
        if serviceType == .add {
//            guard let planId = stepCreateModel?.planId else {return nil}
            return stepCreateModel?.getBodyParameters()
        } else {
            return stepEditModel?.getBodyParameters()
        }
    }
    
    override func path() -> String {
        var path = TRPConfig.ApiCall.timelineStep.link
        if serviceType == .edit {
            if let stepId = stepEditModel?.stepId {
                path += "/\(stepId)"
            }
        }
        return path
    }
    
}
