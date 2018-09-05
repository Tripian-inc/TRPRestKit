//
//  TRPParentJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 7.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
/// Parent Json parser.
public class TRPParentJsonModel: Decodable {

    public var status: Int
    public var success: Bool
    public var message: String?;
    var pagination: TRPPaginationJsonModel?
    
    enum ParentCodingKeys: String, CodingKey {
        case status
        case message
        case success
        case pagination
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ParentCodingKeys.self);
        status = try values.decode(Int.self, forKey: .status);
        success = try values.decode(Bool.self, forKey: TRPParentJsonModel.ParentCodingKeys.success)
        message = try values.decodeIfPresent(String.self, forKey: .message);
        
        if let pagination = try? values.decodeIfPresent(TRPPaginationJsonModel.self, forKey: .pagination) {
            self.pagination = pagination
        }
    }
    
}


struct TRPMetaJsonModel:Decodable{
    var pagination: TRPPaginationJsonModel?
}

//ETODO: Yorum satırlarını yaz.
struct TRPPaginationJsonModel: Decodable{
    
    var total: Int = 0;
    var count: Int = 0;
    var perPage: Int = 0
    var currentPage: Int = 0;
    var totalPages: Int = 0;
    var links: TRPPaginationLinkJsonModel?
    
    enum CodingKeys: String, CodingKey{
        case total = "total"
        case count = "count"
        case perPage = "per_page";
        case currentPage = "current_page";
        case totalPages = "total_pages";
        case links = "links";
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //This value were renamed.
        self.perPage = try values.decodeIfPresent(Int.self, forKey: .perPage) ?? 0
        self.currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage) ?? 0
        //This values weren't renamed.
        self.total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
        self.count = try values.decodeIfPresent(Int.self, forKey: .count) ?? 0
        self.totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        
        if let links = try? values.decodeIfPresent(TRPPaginationLinkJsonModel.self, forKey: .links){
            self.links = links;
        }
    }
    
}

struct TRPPaginationLinkJsonModel: Decodable {
    
    var next: String?
    var previous: String?
    
    enum CodingKeys: String, CodingKey{
        case next = "next"
        case previous = "previous"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let next = try? values.decodeIfPresent(String.self, forKey: .next) {
            self.next = next
        }
        if let previous = try? values.decodeIfPresent(String.self, forKey: .previous) {
            self.previous = previous
        }
    }
}

