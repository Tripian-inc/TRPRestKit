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
    
    var meta: TRPMetaJsonModel?;
    public var status: Bool = false
    public var message: TRPParentMessageJsonModel?;
    
    
    enum ParentCodingKeys: String, CodingKey {
        case meta
        case status
        case message
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ParentCodingKeys.self);
        meta = try values.decodeIfPresent(TRPMetaJsonModel.self, forKey: .meta);
        status = try values.decodeIfPresent(Bool.self, forKey: .status) ?? false;
        message = try values.decodeIfPresent(TRPParentMessageJsonModel.self, forKey: .message);
    }
    
}

public struct TRPParentMessageJsonModel:Decodable {
    public var code: String?;
    public var httpCode: Int?;
    public var description: String?;
    
    enum ParentCodingKeys: String, CodingKey {
        case code
        case httpCode = "http_code"
        case description
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ParentCodingKeys.self);
        code = try values.decodeIfPresent(String.self, forKey: .code);
        httpCode = try values.decodeIfPresent(Int.self, forKey: .httpCode);
        description = try values.decodeIfPresent(String.self, forKey: .description);
    }
}
struct TRPMetaJsonModel:Decodable{
    var pagination: TRPMetasPaginationJsonModel?
}

//ETODO: Yorum satırlarını yaz.
struct TRPMetasPaginationJsonModel: Decodable{
    
    var total: Int = 0;
    var count: Int = 0;
    var perPage: Int = 0
    var currentPage: Int = 0;
    var totalPages: Int = 0;
    var links: TRPMetasPaginationLinksJsonModel?
    
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
        
        if let links = try? values.decodeIfPresent(TRPMetasPaginationLinksJsonModel.self, forKey: .links){
            self.links = links;
        }
    }
    
}

struct TRPMetasPaginationLinksJsonModel: Decodable {
    
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

