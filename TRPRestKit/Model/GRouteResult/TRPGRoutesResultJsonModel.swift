//
//  TRPGRoutesResultJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPGRoutesResultJsonModel: TRPParentJsonModel {
    
    public var data: [String:[String:TRPGRoutesResultWalkDriveJsonModel]]?;
    public var waitResult: TRPGrouteWaitInfoModel?;
    
    enum CodingKeys: String, CodingKey { case data }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        if let route = try? values.decodeIfPresent([String:[String:TRPGRoutesResultWalkDriveJsonModel]].self, forKey: .data) {
            data = route
        }else if let wait = try? values.decodeIfPresent(TRPGrouteWaitInfoModel.self, forKey: .data) {
            waitResult = wait
        }
        try super.init(from: decoder);
    }
    
}
