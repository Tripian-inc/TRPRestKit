//
//  TRPRestKit+Reaction.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - User Reaction
extension TRPRestKit {
    
    // return [TRPReactionModel]
    public func getUserReaction(withTripHash hash: String, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        getUserReactionService(tripHash: hash)
    }
    
    private func getUserReactionService(tripHash hash: String) {
        let service = TRPGetUserReactionServices(tripHash: hash)
        service.completion = { result, error, pagination in
            self.genericParseAndPost([TRPReactionModel].self, result, error, pagination)
        }
        service.connection()
    }
    
    public func addUserReaction(poiId: String, stepId: Int, reaction: UserReactionType? = nil, comment: String? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userReactionService(poiId: poiId, stepId: stepId, reaction: reaction, comment: comment)
    }
    
    public func updateUserReaction(id: Int,
                                   poiId: String? = nil,
                                   stepId: Int? = nil,
                                   reaction: UserReactionType? = nil,
                                   comment: String? = nil,
                                   completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userReactionService(id: id, poiId: poiId, stepId: stepId, reaction: reaction, comment: comment)
    }
    
    private func userReactionService(id: Int? = nil, poiId: String? = nil, stepId: Int? = nil, reaction: UserReactionType? = nil, comment: String? = nil) {
        var services: TRPUserReactionServices?
        //Update
        if let id = id {
            services = TRPUserReactionServices(id: id, stepId: stepId, poiId: poiId, reaction: reaction, comment: comment)
        } else if let poiId = poiId, let step = stepId {
        //Add
            services = TRPUserReactionServices(stepId: step, poiId: poiId, reaction: reaction, comment: comment)
        }
        guard let service = services else {return}
        service.completion = { result, error, pagination in
            self.genericParseAndPost(TRPReactionModel.self, result, error, pagination)
        }
        service.connection()
    }
    
    public func deleteUserReaction(id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        deleteUserReactionService(id)
    }
    
    private func deleteUserReactionService(_ reactionId: Int) {
        let deleteService = TRPDeleteUserReactionServices(id: reactionId)
        deleteService.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        deleteService.connection()
    }
}

//MARK: - User Reservation
extension TRPRestKit {
    
    // [TRPReservationInfoModel]
    public func getUserReservation(cityId: Int, from: String? = nil, to: String? = nil, provider: String? = nil, limit: Int? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        getUserReservationServices(cityId: cityId, from: from, to: to, provider: provider, limit: limit)
    }
    
    // [TRPReservationInfoModel]
    public func getUserReservation(tripHash: String, from: String? = nil, to: String? = nil, provider: String? = nil, limit: Int? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        getUserReservationServices(tripHash: tripHash, from: from, to: to, provider: provider, limit: limit)
    }
    
    // [TRPReservationInfoModel]
    public func getUserReservation(poiId: String, from: String? = nil, to: String? = nil, provider: String? = nil, limit: Int? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        getUserReservationServices(poiId: poiId, from: from, to: to, provider: provider, limit: limit)
    }
    
    private func getUserReservationServices(cityId: Int? = nil,
                                            tripHash: String? = nil,
                                            poiId: String? = nil,
                                            from: String? = nil,
                                            to: String? = nil,
                                            provider: String? = nil,
                                            limit: Int? = nil) {
        let services = TRPUserReservationServices()
        if let cityId = cityId, cityId != 0 {
            services.cityId = cityId
        }
        
        services.tripHash = tripHash
        services.poiId = poiId
        services.from = from
        services.to = to
        services.provider = provider
        services.limit = limit
        services.completion = { (result, error, pagination) in
            self.genericParseAndPost([TRPReservationInfoModel].self, result, error, pagination)
        }
        services.connection()
    }
    
    //Add
    public func addUserReservation(key: String, provider: String, tripHash: String? = nil, poiId: String? = nil, value: [String : Any]? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        addUserReservationServices(key: key, provider: provider, tripHash: tripHash, poiId: poiId,value: value)
    }
    
    private func addUserReservationServices(key: String, provider: String, tripHash: String? = nil, poiId: String? = nil, value:[String : Any]? = nil) {
        let service = TRPAddUpadateUserReservationServices(key: key, provider: provider, tripHash: tripHash, poiId: poiId,value: value)
        service.completion = { result, error, pagination in
            self.genericParseAndPost(TRPReservationInfoModel.self, result, error, pagination)
        }
        service.connection()
    }
    
    //Update
    public func updateUserReservation(id: Int,
                                      key: String,
                                      provider: String,
                                      tripHash: String? = nil,
                                      poiId: String? = nil,
                                      value: [String : Any]? = nil,
                                      completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        let service = TRPAddUpadateUserReservationServices(reservationId:id,
                                                           key: key,
                                                           provider: provider,
                                                           tripHash: tripHash,
                                                           poiId: poiId,
                                                           value: value)
        service.completion = { result, error, pagination in
            self.genericParseAndPost(TRPReservationInfoModel.self, result, error, pagination)
        }
        service.connection()
    }
    
    //Delete
    public func deleteUserReservation(id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        deletePutUserReservationServices(id: id)
    }
    
    private func deletePutUserReservationServices(id: Int) {
        let service = TRPUserReservationDeletePutServices(id: id)
        service.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        service.connection()
    }
    
}


//MARK: - Token Controller
extension TRPRestKit {
    public func saveToken(_ token: TRPToken) {
        TripianTokenController().saveTokenInfo(token)
    }
}

//MARK: - Offers
extension TRPRestKit {
    
    public func getOffers(dateFrom: String,
                          dateTo: String,
                          poiIds: [String]?,
                          typeId: [Int]?,
                          boundary: LocationBounds? = nil,
                          page: Int?,
                          limit: Int?,
                          excludeOptIn: Bool?,
                          completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        getOffersService(dateFrom: dateFrom, dateTo: dateTo, poiIds: poiIds, typeId: typeId, boundary: boundary, page: page, limit: limit, excludeOptIn: excludeOptIn)
    }
    
    public func getOffer(id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        getOffersService(offerId: id)
    }
    
    private func getOffersService(offerId: Int? = nil,
                                  dateFrom: String? = nil,
                                  dateTo: String? = nil,
                                  poiIds: [String]? = nil,
                                  typeId: [Int]? = nil,
                                  boundary: LocationBounds? = nil,
                                  page: Int? = 1,
                                  limit: Int? = 50,
                                  excludeOptIn: Bool? = false) {
        var service = TRPGetOfferServices()
        if let offerId = offerId {
            service = TRPGetOfferServices(offerId: offerId)
        }
        if let dateFrom = dateFrom, let dateTo = dateTo {
            service = TRPGetOfferServices(dateFrom: dateFrom, dateTo: dateTo)
        }
        service.poiIds = poiIds
        service.typeId = typeId
        service.boundary = boundary
        service.page = page
        service.limit = limit
        service.excludeOptIn = excludeOptIn
        service.completion = { result, error, pagination in
            self.genericParseAndPost([TRPOfferInfoModel].self, result, error, pagination)
        }
        service.connection()
    }
}

//MARK: - Opt-In Offers
extension TRPRestKit {
    
    public func getOptInOffers(dateFrom: String?,
                               dateTo: String?,
                               page: Int?,
                               limit: Int?,
                               completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        getOptInOffersService(dateFrom: dateFrom, dateTo: dateTo, page: page, limit: limit)
    }
    
    private func getOptInOffersService(dateFrom: String? = nil,
                                       dateTo: String? = nil,
                                       page: Int? = 1,
                                       limit: Int? = 50) {
        let service = TRPGetOptInOfferServices(dateFrom: dateFrom, dateTo: dateTo, page: page, limit: limit)
        service.completion = { result, error, pagination in
            self.genericParseAndPost([TRPPoiInfoModel].self, result, error, pagination)
        }
        service.connection()
    }
    
    public func addOptInOffer(offerId: Int,
                              claimDate: String?,
                              completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        optInOffersService(offerId: offerId, claimDate: claimDate, mode: .add)
    }
    
    public func deleteOptInOffer(offerId: Int,
                                 completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        optInOffersService(offerId: offerId, mode: .delete)
    }
    
    private func optInOffersService(offerId: Int,
                                    claimDate: String? = nil,
                                    mode: TRPUserFavorite.Mode) {
        
        var service: TRPOptInOfferServices?
        if mode == .add {
            service = TRPOptInOfferServices(offerId: offerId, claimDate: claimDate)
        } else {
            service = TRPOptInOfferServices(offerId: offerId)
        }
        guard let service = service else {
            return
        }
        
        service.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        service.connection()
    }
}


//MARK: - Language Texts
extension TRPRestKit {
    public func getFrontendLanguages(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        languagesServices()
    }
    
    private func languagesServices() {
        let langugaesService = TRPLanguagesServices()
        langugaesService.completion = {   (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPLanguagesInfoModel {
                self.postData(result: serviceResult)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        langugaesService.connection()
    }
}

