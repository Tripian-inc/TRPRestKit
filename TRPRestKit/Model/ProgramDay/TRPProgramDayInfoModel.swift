//
//  TRPProgramDayInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPProgramDayInfoModel: Decodable {
    var id: Int
    var hash: String
    var date: String?
    var startTime: String?
    var endTime: String?
    var steps: [TRPProgramStep]?
    
    //TODO: - preferences eklenecek
    enum CodingKeys: String, CodingKey {
        case id
        case hash
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case steps
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        self.date = try values.decodeIfPresent(String.self, forKey: .date)
        self.startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        self.endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        
        if let steps = try? values.decodeIfPresent([TRPProgramStep].self, forKey: .steps) {
            self.steps = steps
        }
        
    }
}
