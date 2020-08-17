//
//  TRPImageModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPImageModel: NSObject, Decodable {
    
    /// An Int value. Unique id of a city.
    public var url: String
    public var imageOwner: TRPImageOwnerModel?
   
    /// Tag matcher
    private enum CodingKeys: String, CodingKey {
        case url
        case imageOwner = "image_owner"
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try values.decode(String.self, forKey: .url)
        self.imageOwner = try values.decodeIfPresent(TRPImageOwnerModel.self, forKey: .imageOwner)
    }
    
}
