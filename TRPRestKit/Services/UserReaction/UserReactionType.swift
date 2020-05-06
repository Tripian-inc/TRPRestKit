//
//  UserReactionType.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 1.05.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public enum UserReactionType: String {
    case thumbsUp = "Thumbs Up"
    case thumbsDown = "Thumbs Down"
    case neutral = "Neutral"
}

public enum UserReactionComment: String {
    case iHaveAlreadyVisited = "I_HAVE_ALREADY_VISITED"
    case iDontLikePlace = "I_DONT_LIKE_PLACE"
}
