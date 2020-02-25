//
//  TRPCompanionModel.swift
//  TRPRestKit
//
//  Created by Rozeri Dağtekin on 6/26/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// Companion model
import Foundation

/// This model provide you to use information of user.
public struct TRPCompanionModel: Decodable {
    /// A Int value. Id of the companion.
    public var id: Int?
    /// A String value. Name of the companion.
    public var name: String?
    /// A String value. Last name of the companion.
    public var answers: String?
    /// A String value. Age of the companion.
    public var age: Int?

    private enum CodingKeys: String, CodingKey {case id, name, answers, age}
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.answers = try values.decodeIfPresent(String.self, forKey: .answers)
        if let age = try? values.decodeIfPresent(Int.self, forKey: .age) {
            self.age = age
        }
        if let strAge = try? values.decodeIfPresent(String.self, forKey: .age) {
            if let strAge = strAge, let intAge = Int(strAge) {
                self.age = intAge
            }
        }
    
    }
    
}
