//
//  TRPProgramDayInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// The struct provides you to plan of day. Thera are pois in a Daily Plan.
/// Pois were recommended by Tripian.
public struct TRPPlansInfoModel: Decodable {
    
    /// An Int value. Id of plan
    public var id: Int
    
    /// A String value. Date of plan
    public var date: String
    /// A String value. Start time of plan
    public var startTime: String?
    /// A String value. End time of plan
    public var endTime: String?
    /// A TRPPlanPoi array. Indicates a pois to go within a day.
    public var steps: [TRPStepInfoModel]
    
    /**
        Indicates whether the plan was generated.
     
     *  0: The plan hasn't generated yet.
     * -1: The plan was generated but the plan hasn't any poi.
     *  1: The plan was generated and it has pois.
     */
    public var generatedStatus: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case steps
        case generate = "generated_status"
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        
        self.date = try values.decode(String.self, forKey: .date)
        
        self.startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        self.endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        self.generatedStatus = try values.decode(Int.self, forKey: .generate)
        //todo:- alk kod açılacak test için yapıldı
        if let planPoints = ((try? values.decodeIfPresent([TRPStepInfoModel].self, forKey: .steps)) as [TRPStepInfoModel]??) {
            self.steps = planPoints ?? []
        } else {
            self.steps = []
        }
        
    }
    
}
