//
//  TRPConfigListParentJsonModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 26.09.2024.
//  Copyright © 2024 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPConfigListParentJsonModel: TRPParentJsonModel {
    
    public var data: TRPConfigListJsonModel?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent(TRPConfigListJsonModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}

internal class TRPConfigListJsonModel: Codable {
    
    public var  apiKey: String
    public var  whiteLabels: ConfigWhiteLabels
    public var  baseFeatures: ConfigBaseFeatures
    public var  providers: ConfigProviders
    public var  sbt: SBT
    public var  androidVersionCode: Int
    public var  androidVersionName: String
}
// WhiteLabels Model
struct ConfigWhiteLabels: Codable {
    let reverseProxyUrl: String
    let brandName: String
    let brandUrl: String
    let landingPageUrl: String
    let imagePaths: ConfigImagePaths
    let theme: ConfigTheme
    let availableThemes: [String]
    let googleAnalyticsUrl: AnalyticsUrl
    let googleAnalyticsKey: AnalyticsKey
    let providers: [String]
    let cognito: Cognito
    let rootPath: String
    let ppUrl: String
    let tosUrl: String
    let defaultDestinationId: Int
    let languages: [String]
    let dealsPageUrl: String
    let externalMenuLinks: [String: String]
}

// ImagePaths Model
struct ConfigImagePaths: Codable {
    let logoPathDark: String
    let logoPathLight: String
    let formHeaderImgUrl: String
    let formBgImgUrl: String
    let appBackgroundImgUrl: String
}

// Theme Model
struct ConfigTheme: Codable {
    let dark: ThemeProperties
    let light: ThemeProperties
}

// ThemeProperties Model
struct ThemeProperties: Codable {
    let secondary: String
    let headerTextColor: String
    let headerBg: String
    let success: String
    let background: String
    let warning: String
    let textPrimary: String
    let danger: String
    let primary: String
    let info: String
}


// AnalyticsUrl Model
struct AnalyticsUrl: Codable {
    let customer: String
    let business: String
}

// AnalyticsKey Model
struct AnalyticsKey: Codable {
    let customer: String
    let business: String
}

// Cognito Model
struct Cognito: Codable {
    let clientId: String
    let domain: String
    let region: String
    let identityProviders: [String]
}

// BaseFeatures Model
struct ConfigBaseFeatures: Codable {
    let showRegister: Bool
    let showLogin: Bool
    let showSideNav: Bool
    let showHome: Bool
    let showUserProfile: Bool
    let showChangePassword: Bool
    let showTripModeQuestion: Bool
    let showCreateTrip: Bool
    let showUpdateTrip: Bool
    let showOverview: Bool
    let showOffers: Bool
    let showStepCardThumbs: Bool
    let showStepScoreDetail: Bool
    let loginWithToken: Bool
    let loginWithHash: Bool
    let saveSession: Bool
    let showTravelGuide: Bool
    let showVoucher: Bool
    let showSaveTrip: Bool
    let showAccommodationPois: Bool
    let sharedTrip: Bool
    let enableCustomPoiCreation: Bool
    let enableCustomEventCreation: Bool
    let showCustomPoiResults: Bool
    let qrReader: String
    let widgetTheme1: Bool
}

// Providers Model
struct ConfigProviders: Codable {
    let tourAndTicket: [ConfigProviderDetail]
    let transportation: [ConfigProviderDetail]
    let restaurant: [ConfigProviderDetail]
    let accommodation: [ConfigProviderDetail]
}

// ProviderDetail Model
struct ConfigProviderDetail: Codable {
    let id: Int
    let name: String
    let apiKey: String
    let apiUrl: String
    let clientId: String
    let prod: Bool
}

// SBT Model
struct SBT: Codable {
    let campaignDefaultCurrency: String
    let offerTypes: [String]
}

//internal class TRP
