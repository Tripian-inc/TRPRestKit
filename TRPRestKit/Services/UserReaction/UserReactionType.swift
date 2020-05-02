//
//  UserReactionType.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 1.05.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public enum UserReactionType: String {
    case thumbsUp = "THUMBS UP"
    case thumbsDown = "THUMBS DOWN"
}

public enum UserReactionComment: String {
    case iHaveAlreadySeen = "I_HAVE_ALREADY_SEEN"
    case notInterest = "NOT_INTEREST"
}
