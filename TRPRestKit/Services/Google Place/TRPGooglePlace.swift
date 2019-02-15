//
//  TRPGooglePlace.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 5.02.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
open class TRPGooglePlace: NSObject {
    
    public let id: String
    public let mainAddress: String
    public let secondaryAddress: String
    
    override open var description: String {
        get { return "\(mainAddress), \(secondaryAddress)" }
    }
    
    init(id: String, mainAddress: String, secondaryAddress: String) {
        self.id = id
        self.mainAddress = mainAddress
        self.secondaryAddress = secondaryAddress
    }
    
    convenience init(prediction: [String: Any]) {
        let structuredFormatting = prediction["structured_formatting"] as? [String: Any]
        self.init(
            id: prediction["place_id"] as? String ?? "",
            mainAddress: structuredFormatting?["main_text"] as? String ?? "",
            secondaryAddress: structuredFormatting?["secondary_text"] as? String ?? ""
        )
    }
}

