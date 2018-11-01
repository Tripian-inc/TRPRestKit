//
//  TRPRoutesInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesInfoJsonModel: Decodable {
    
    public var hash: String;
    var time: TRPRoutesTimeJsonModel?;
    
}
