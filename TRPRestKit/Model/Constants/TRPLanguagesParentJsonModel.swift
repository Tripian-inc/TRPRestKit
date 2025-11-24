//
//  TRPLanguagesParentJsonModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 8.09.2024.
//  Copyright © 2024 Evren Yaşar. All rights reserved.
//

import Foundation

public struct TRPLanguagesInfoModel: Codable {
    public let translations: [String: Any]
    public let langCodes: [TRPLanguagesLangCodeModel]
    
    private enum CodingKeys: String, CodingKey {
        case translations
        case langCodes = "lang_codes"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let translationsData = try container.decode([String: AnyCodable].self, forKey: .translations)
        self.translations = translationsData.mapValues { $0.value }
        self.langCodes = try container.decode([TRPLanguagesLangCodeModel].self, forKey: .langCodes)
//        self.translations = try container.decode([String: Any].self, forKey: .translations)
//        self.langCodes = try container.decode([TRPLanguagesLangCodeModel].self, forKey: .langCodes)
    }
    
    // Encodable implementation
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let encodableTranslations = translations.mapValues { AnyCodable($0) }
        try container.encode(encodableTranslations, forKey: .translations)
        try container.encode(langCodes, forKey: .langCodes)
    }
}

public struct TRPLanguagesLangCodeModel: Codable {
    public let value: String
    public let label: String
    
    private enum CodingKeys: String, CodingKey {
        case value
        case label
    }
    
    // Codable provides automatic encoding/decoding, so the init(from:) and encode(to:) methods are optional unless you need custom behavior.
    
    // Optional initializer
    public init(value: String, label: String) {
        self.value = value
        self.label = label
    }
}
