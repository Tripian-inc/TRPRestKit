//
//  TRPTimelinePlansInfoModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation

/// The struct provides you to plan of day. Thera are pois in a Daily Plan.
/// Pois were recommended by Tripian.
public struct TRPTimelinePlansInfoModel: Decodable {
    
    /// An Int value. Id of plan
    public var id: String
    
    /// A String value. Start time of plan
    public var startDate: String?
    /// A String value. End time of plan
    public var endDate: String?
    /// A TRPPlanPoi array. Indicates a pois to go within a day.
    public var steps: [TRPStepInfoModel]
    
    public var available: Bool?
    public var tripType: Int?
    public var name: String?
    public var desciption: String?
    /**
        Indicates whether the plan was generated.
     
     *  0: The plan hasn't generated yet.
     * -1: The plan was generated but the plan hasn't any poi.
     *  1: The plan was generated and it has pois.
     */
    public var generatedStatus: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case startDate
        case endDate
        case available
        case tripType
        case name
        case desciption
        case steps
        case generate = "generatedStatus"
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.desciption = try values.decodeIfPresent(String.self, forKey: .desciption)
        self.startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        self.endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        self.generatedStatus = try values.decode(Int.self, forKey: .generate)
        
        if let planPoints = try? values.decodeIfPresent([FailableDecodable<TRPStepInfoModel>].self, forKey: .steps) {
            let result = planPoints ?? []
            
            self.steps = result.compactMap({$0.base})
        } else {
            self.steps = []
        }
        
    }
    
}
