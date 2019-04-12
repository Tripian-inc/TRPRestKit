//
//  TRPGrouteWaitInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 24.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPGrouteWaitInfoModel:Decodable {
    public var wait: Bool?
    public var hash: String?
    
    private enum CodingKeys: String, CodingKey {
        case wait
        case hash
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        wait = try values.decodeIfPresent(Bool.self, forKey: .wait);
        hash = try values.decodeIfPresent(String.self, forKey: .hash);
    }
    
}
