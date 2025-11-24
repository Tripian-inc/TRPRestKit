//
//  TRPCityInformation.swift
//  TRPDataLayer
//
//  Created by Cem Çaygöz on 4.09.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

public struct TRPCityInformationDataJsonModel: Codable {
    public let id: String?
    public let information: TRPCityInformationJsonModel?
}

public struct TRPCityInformationJsonModel: Codable {
    public let wifiInformation: TRPCityWifiInformationJsonModel?
    public let lifeQualityIndices: TRPCityLifeQualityIndicesJsonModel?
    public let emergencyNumbers: TRPCityEmergencyNumbersJsonModel?
    public let powerInformation: TRPCityPowerInformationJsonModel?
    public let bestTimeToVisit: TRPCityBestTimeToVisitJsonModel?
}

public struct TRPCityWifiInformationJsonModel: Codable {
    public let mobile: String?
    public let broadband: String?
}

public struct TRPCityLifeQualityIndicesJsonModel: Codable {
    public let safetyIndex: TRPCityQualityIndexJsonModel?
    public let healthCareIndex: TRPCityQualityIndexJsonModel?
    public let propertyPriceToIncomeRatio: TRPCityQualityIndexJsonModel?
    public let trafficCommuteTimeIndex: TRPCityQualityIndexJsonModel?
    public let purchasingPowerIndex: TRPCityQualityIndexJsonModel?
    public let qualityOfLifeIndex: TRPCityQualityIndexJsonModel?
    public let climateIndex: TRPCityQualityIndexJsonModel?
    public let pollutionIndex: TRPCityQualityIndexJsonModel?
    public let costOfLivingIndex: TRPCityQualityIndexJsonModel?
}

public struct TRPCityQualityIndexJsonModel: Codable {
    public let rating: String?
    public let value: Double?
}

public struct TRPCityEmergencyNumbersJsonModel: Codable {
    public let fire: String?
    public let police: String?
    public let ambulance: String?
    public let notes: String?
}

public struct TRPCityPowerInformationJsonModel: Codable {
    public let plugs: [String]?
    public let voltage: String?
    public let frequency: String?
}

public struct TRPCityBestTimeToVisitJsonModel: Codable {
    public let notes: String?
    public let offSeason: TRPCitySeasonJsonModel?
    public let peakSeason: TRPCitySeasonJsonModel?
    public let shoulderSeason: TRPCitySeasonJsonModel?
}

public struct TRPCitySeasonJsonModel: Codable {
    public let description: String?
    public let months: [String]?
}
