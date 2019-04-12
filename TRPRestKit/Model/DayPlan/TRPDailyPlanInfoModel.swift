//
//  TRPProgramDayInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPDailyPlanInfoModel: Decodable {
    public var id: Int
    public var hash: String
    public var date: String
    public var startTime: String?
    public var endTime: String?
    public var planPois: [TRPPlanPoi]
    public var generate: Int
    
    //TODO: - preferences eklenecek
    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case planPoints = "dailyplanpoi"
        case generate
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        self.date = try values.decode(String.self, forKey: .date)
        self.generate = try values.decode(Int.self, forKey: .generate)
        self.startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        self.endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        //todo:- alk kod açılacak test için yapıldı
        if let planPoints = try? values.decodeIfPresent([TRPPlanPoi].self, forKey: .planPoints) {
            self.planPois = planPoints ?? []
        }else {
            self.planPois = []
        }
        
    }
    
}
