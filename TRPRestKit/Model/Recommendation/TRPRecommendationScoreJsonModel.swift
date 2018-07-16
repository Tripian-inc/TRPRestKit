//
//  TRPRecommendationScoreJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRecommendationScoreJsonModel: Decodable {
    var distance: Float?;
    var rating: Float?;
    var popularity: Int?;
    var keywordEngine: Int?;
}
