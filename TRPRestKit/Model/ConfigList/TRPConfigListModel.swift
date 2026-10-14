//
//  TRPConfigListModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The platform configuration `misc/config-list` answers with. Every field is optional and a
/// missing or wrongly typed one decodes as nil, so fields the backend adds or drops never fail the call.
public struct TRPConfigListModel: Codable {
    public let apiKey: String?
    public let whiteLabels: TRPConfigWhiteLabelsModel?
    public let baseFeatures: TRPConfigBaseFeaturesModel?
    public let providers: TRPConfigProvidersModel?
    public let sbt: TRPConfigSBTModel?
    public let androidVersionCode: Int?
    public let androidVersionName: String?
    public let aiSupport: Bool?

    private enum CodingKeys: String, CodingKey {
        case apiKey, whiteLabels, baseFeatures, providers, sbt, androidVersionCode, androidVersionName, aiSupport
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        apiKey = container.lenient(String.self, forKey: .apiKey)
        whiteLabels = container.lenient(TRPConfigWhiteLabelsModel.self, forKey: .whiteLabels)
        baseFeatures = container.lenient(TRPConfigBaseFeaturesModel.self, forKey: .baseFeatures)
        providers = container.lenient(TRPConfigProvidersModel.self, forKey: .providers)
        sbt = container.lenient(TRPConfigSBTModel.self, forKey: .sbt)
        androidVersionCode = container.lenient(Int.self, forKey: .androidVersionCode)
        androidVersionName = container.lenient(String.self, forKey: .androidVersionName)
        aiSupport = container.lenient(Bool.self, forKey: .aiSupport)
    }
}

/// The third-party providers enabled for the platform, grouped by what they offer.
public struct TRPConfigProvidersModel: Codable {
    public let tourAndTicket: [TRPConfigProviderModel]?
    public let transportation: [TRPConfigProviderModel]?
    public let restaurant: [TRPConfigProviderModel]?
    public let accommodation: [TRPConfigProviderModel]?

    private enum CodingKeys: String, CodingKey {
        case tourAndTicket, transportation, restaurant, accommodation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tourAndTicket = container.lenient([TRPConfigProviderModel].self, forKey: .tourAndTicket)
        transportation = container.lenient([TRPConfigProviderModel].self, forKey: .transportation)
        restaurant = container.lenient([TRPConfigProviderModel].self, forKey: .restaurant)
        accommodation = container.lenient([TRPConfigProviderModel].self, forKey: .accommodation)
    }
}

/// One provider and the credentials the platform uses with it. `name` is kept as the backend sends it.
public struct TRPConfigProviderModel: Codable {
    public let id: Int?
    public let name: String?
    public let apiKey: String?
    public let apiUrl: String?
    public let clientId: String?
    public let limit: Int?
    public let prod: Bool?

    private enum CodingKeys: String, CodingKey {
        case id, name, apiKey, apiUrl, clientId, limit, prod
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.lenient(Int.self, forKey: .id)
        name = container.lenient(String.self, forKey: .name)
        apiKey = container.lenient(String.self, forKey: .apiKey)
        apiUrl = container.lenient(String.self, forKey: .apiUrl)
        clientId = container.lenient(String.self, forKey: .clientId)
        limit = container.lenient(Int.self, forKey: .limit)
        prod = container.lenient(Bool.self, forKey: .prod)
    }
}

/// Branding, links, sign-in and language settings of the platform.
public struct TRPConfigWhiteLabelsModel: Codable {
    public let reverseProxyUrl: String?
    public let brandName: String?
    public let cookieConsentUrl: String?
    public let brandUrl: String?
    public let landingPageUrl: String?
    public let imagePaths: TRPConfigImagePathsModel?
    public let theme: TRPConfigThemeModel?
    public let availableThemes: [String]?
    public let googleAnalyticsUrl: TRPConfigAnalyticsModel?
    public let googleAnalyticsKey: TRPConfigAnalyticsModel?
    public let providers: [String]?
    public let cognito: TRPConfigCognitoModel?
    public let rootPath: String?
    public let ppUrl: String?
    public let tosUrl: String?
    public let defaultDestinationId: Int?
    public let languages: [String]?
    public let dealsPageUrl: String?
    public let externalMenuLinks: [String: String]?

    private enum CodingKeys: String, CodingKey {
        case reverseProxyUrl, brandName, cookieConsentUrl, brandUrl, landingPageUrl, imagePaths, theme,
             availableThemes, googleAnalyticsUrl, googleAnalyticsKey, providers, cognito, rootPath, ppUrl,
             tosUrl, defaultDestinationId, languages, dealsPageUrl, externalMenuLinks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reverseProxyUrl = container.lenient(String.self, forKey: .reverseProxyUrl)
        brandName = container.lenient(String.self, forKey: .brandName)
        cookieConsentUrl = container.lenient(String.self, forKey: .cookieConsentUrl)
        brandUrl = container.lenient(String.self, forKey: .brandUrl)
        landingPageUrl = container.lenient(String.self, forKey: .landingPageUrl)
        imagePaths = container.lenient(TRPConfigImagePathsModel.self, forKey: .imagePaths)
        theme = container.lenient(TRPConfigThemeModel.self, forKey: .theme)
        availableThemes = container.lenient([String].self, forKey: .availableThemes)
        googleAnalyticsUrl = container.lenient(TRPConfigAnalyticsModel.self, forKey: .googleAnalyticsUrl)
        googleAnalyticsKey = container.lenient(TRPConfigAnalyticsModel.self, forKey: .googleAnalyticsKey)
        providers = container.lenient([String].self, forKey: .providers)
        cognito = container.lenient(TRPConfigCognitoModel.self, forKey: .cognito)
        rootPath = container.lenient(String.self, forKey: .rootPath)
        ppUrl = container.lenient(String.self, forKey: .ppUrl)
        tosUrl = container.lenient(String.self, forKey: .tosUrl)
        defaultDestinationId = container.lenient(Int.self, forKey: .defaultDestinationId)
        languages = container.lenient([String].self, forKey: .languages)
        dealsPageUrl = container.lenient(String.self, forKey: .dealsPageUrl)
        externalMenuLinks = container.lenient([String: String].self, forKey: .externalMenuLinks)
    }
}

/// Logo and background image urls of the platform.
public struct TRPConfigImagePathsModel: Codable {
    public let logoPathDark: String?
    public let logoPathLight: String?
    public let formHeaderImgUrl: String?
    public let formBgImgUrl: String?
    public let appBackgroundImgUrl: String?

    private enum CodingKeys: String, CodingKey {
        case logoPathDark, logoPathLight, formHeaderImgUrl, formBgImgUrl, appBackgroundImgUrl
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        logoPathDark = container.lenient(String.self, forKey: .logoPathDark)
        logoPathLight = container.lenient(String.self, forKey: .logoPathLight)
        formHeaderImgUrl = container.lenient(String.self, forKey: .formHeaderImgUrl)
        formBgImgUrl = container.lenient(String.self, forKey: .formBgImgUrl)
        appBackgroundImgUrl = container.lenient(String.self, forKey: .appBackgroundImgUrl)
    }
}

/// The dark and light colour sets of the platform.
public struct TRPConfigThemeModel: Codable {
    public let dark: TRPConfigThemeColorsModel?
    public let light: TRPConfigThemeColorsModel?

    private enum CodingKeys: String, CodingKey {
        case dark, light
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dark = container.lenient(TRPConfigThemeColorsModel.self, forKey: .dark)
        light = container.lenient(TRPConfigThemeColorsModel.self, forKey: .light)
    }
}

/// Hex colours of one theme.
public struct TRPConfigThemeColorsModel: Codable {
    public let primary: String?
    public let secondary: String?
    public let background: String?
    public let textPrimary: String?
    public let headerBg: String?
    public let headerTextColor: String?
    public let success: String?
    public let info: String?
    public let warning: String?
    public let danger: String?

    private enum CodingKeys: String, CodingKey {
        case primary, secondary, background, textPrimary, headerBg, headerTextColor, success, info, warning, danger
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        primary = container.lenient(String.self, forKey: .primary)
        secondary = container.lenient(String.self, forKey: .secondary)
        background = container.lenient(String.self, forKey: .background)
        textPrimary = container.lenient(String.self, forKey: .textPrimary)
        headerBg = container.lenient(String.self, forKey: .headerBg)
        headerTextColor = container.lenient(String.self, forKey: .headerTextColor)
        success = container.lenient(String.self, forKey: .success)
        info = container.lenient(String.self, forKey: .info)
        warning = container.lenient(String.self, forKey: .warning)
        danger = container.lenient(String.self, forKey: .danger)
    }
}

/// A Google Analytics value for the customer and the business side.
public struct TRPConfigAnalyticsModel: Codable {
    public let customer: String?
    public let business: String?

    private enum CodingKeys: String, CodingKey {
        case customer, business
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        customer = container.lenient(String.self, forKey: .customer)
        business = container.lenient(String.self, forKey: .business)
    }
}

/// The Cognito pool social sign-in goes through.
public struct TRPConfigCognitoModel: Codable {
    public let clientId: String?
    public let domain: String?
    public let region: String?
    public let identityProviders: [String]?

    private enum CodingKeys: String, CodingKey {
        case clientId, domain, region, identityProviders
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        clientId = container.lenient(String.self, forKey: .clientId)
        domain = container.lenient(String.self, forKey: .domain)
        region = container.lenient(String.self, forKey: .region)
        identityProviders = container.lenient([String].self, forKey: .identityProviders)
    }
}

/// Feature switches of the platform.
public struct TRPConfigBaseFeaturesModel: Codable {
    public let showRegister: Bool?
    public let guestLogin: Bool?
    public let showLogin: Bool?
    public let showSideNav: Bool?
    public let showHome: Bool?
    public let showUserProfile: Bool?
    public let showChangePassword: Bool?
    public let showTripModeQuestion: Bool?
    public let showCreateTrip: Bool?
    public let showUpdateTrip: Bool?
    public let showOverview: Bool?
    public let showOffers: Bool?
    public let showStepCardThumbs: Bool?
    public let showStepScoreDetail: Bool?
    public let loginWithToken: Bool?
    public let loginWithHash: Bool?
    public let saveSession: Bool?
    public let showTravelGuide: Bool?
    public let showVoucher: Bool?
    public let showSaveTrip: Bool?
    public let showTimeline: Bool?
    public let showAccommodationPois: Bool?
    public let sharedTrip: Bool?
    public let enableCustomPoiCreation: Bool?
    public let enableCustomEventCreation: Bool?
    public let showCustomPoiResults: Bool?
    public let qrReader: String?
    public let widgetTheme1: Bool?
    public let widgetTheme2: Bool?
    public let widgetTheme3: Bool?
    public let apiLoggingEnabled: Bool?
    public let landingPage: String?

    private enum CodingKeys: String, CodingKey {
        case showRegister, guestLogin, showLogin, showSideNav, showHome, showUserProfile, showChangePassword,
             showTripModeQuestion, showCreateTrip, showUpdateTrip, showOverview, showOffers, showStepCardThumbs,
             showStepScoreDetail, loginWithToken, loginWithHash, saveSession, showTravelGuide, showVoucher,
             showSaveTrip, showTimeline, showAccommodationPois, sharedTrip, enableCustomPoiCreation,
             enableCustomEventCreation, showCustomPoiResults, qrReader, widgetTheme1, widgetTheme2, widgetTheme3,
             apiLoggingEnabled, landingPage
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        showRegister = container.lenient(Bool.self, forKey: .showRegister)
        guestLogin = container.lenient(Bool.self, forKey: .guestLogin)
        showLogin = container.lenient(Bool.self, forKey: .showLogin)
        showSideNav = container.lenient(Bool.self, forKey: .showSideNav)
        showHome = container.lenient(Bool.self, forKey: .showHome)
        showUserProfile = container.lenient(Bool.self, forKey: .showUserProfile)
        showChangePassword = container.lenient(Bool.self, forKey: .showChangePassword)
        showTripModeQuestion = container.lenient(Bool.self, forKey: .showTripModeQuestion)
        showCreateTrip = container.lenient(Bool.self, forKey: .showCreateTrip)
        showUpdateTrip = container.lenient(Bool.self, forKey: .showUpdateTrip)
        showOverview = container.lenient(Bool.self, forKey: .showOverview)
        showOffers = container.lenient(Bool.self, forKey: .showOffers)
        showStepCardThumbs = container.lenient(Bool.self, forKey: .showStepCardThumbs)
        showStepScoreDetail = container.lenient(Bool.self, forKey: .showStepScoreDetail)
        loginWithToken = container.lenient(Bool.self, forKey: .loginWithToken)
        loginWithHash = container.lenient(Bool.self, forKey: .loginWithHash)
        saveSession = container.lenient(Bool.self, forKey: .saveSession)
        showTravelGuide = container.lenient(Bool.self, forKey: .showTravelGuide)
        showVoucher = container.lenient(Bool.self, forKey: .showVoucher)
        showSaveTrip = container.lenient(Bool.self, forKey: .showSaveTrip)
        showTimeline = container.lenient(Bool.self, forKey: .showTimeline)
        showAccommodationPois = container.lenient(Bool.self, forKey: .showAccommodationPois)
        sharedTrip = container.lenient(Bool.self, forKey: .sharedTrip)
        enableCustomPoiCreation = container.lenient(Bool.self, forKey: .enableCustomPoiCreation)
        enableCustomEventCreation = container.lenient(Bool.self, forKey: .enableCustomEventCreation)
        showCustomPoiResults = container.lenient(Bool.self, forKey: .showCustomPoiResults)
        qrReader = container.lenient(String.self, forKey: .qrReader)
        widgetTheme1 = container.lenient(Bool.self, forKey: .widgetTheme1)
        widgetTheme2 = container.lenient(Bool.self, forKey: .widgetTheme2)
        widgetTheme3 = container.lenient(Bool.self, forKey: .widgetTheme3)
        apiLoggingEnabled = container.lenient(Bool.self, forKey: .apiLoggingEnabled)
        landingPage = container.lenient(String.self, forKey: .landingPage)
    }
}

/// Campaign settings of the platform.
public struct TRPConfigSBTModel: Codable {
    public let campaignDefaultCurrency: String?
    public let offerTypes: [String]?

    private enum CodingKeys: String, CodingKey {
        case campaignDefaultCurrency, offerTypes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        campaignDefaultCurrency = container.lenient(String.self, forKey: .campaignDefaultCurrency)
        offerTypes = container.lenient([String].self, forKey: .offerTypes)
    }
}

private extension KeyedDecodingContainer {

    /// Nil when the key is missing, null or holds a value of another type.
    func lenient<T: Decodable>(_ type: T.Type, forKey key: Key) -> T? {
        return (try? decodeIfPresent(type, forKey: key)) ?? nil
    }
}
