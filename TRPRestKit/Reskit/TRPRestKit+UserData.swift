//
//  TRPRestKit+UserData.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Companions.
extension TRPRestKit {
    
    /// Add companion by adding name(Optional), age(Optional), Answers(Optional) and completion parameters.
    ///
    ///
    /// - Parameters:
    ///   - name: A String that refers to name of the companion
    ///   - answers: An Integer array that refers to preferences of the companion
    ///   - age: An Integer that refers to age of the companion (Optional).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPCompanionModel** object.
    public func addCompanion(name: String,
                             answers: [Int],
                             age: Int,
                             title: String?,
                             completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        companionPutPostService(name: name, title: title, answers: answers, age: age)
    }
    
    /// Update companion information (must be logged in with access token), such as name and answers
    ///
    /// - Parameters:
    ///   - id: An Integer that refers to id of the given companion.
    ///   - name: A String that refers to name of the given companion (Optional).
    ///   - age: An Integer that refers to age of the given companion (Optional).
    ///   - answers: An Integer array that refers to preferences of the given companion (Optional).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPCompanionModel** object.
    public func updateCompanion(id: Int,
                                name: String,
                                answers: [Int]?,
                                age: Int?,
                                title: String?,
                                completion: @escaping CompletionHandler) {
    self.completionHandler = completion
        companionPutPostService(id: id, name: name, title: title, answers: answers, age: age)
    }
    
    /// Delete companion by adding companionId and completion parameters.
    ///
    /// - Parameters:
    ///   - companionId: An Integer that refers to id of the given companion that is going to be deleted.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPCompanionModel** object.
    public func removeCompanion(companionId: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        companionDeleteService(id: companionId)
    }
    
    private func companionDeleteService(id: Int) {
        let service = TRPCompanionDeleteServices(id: id)
        service.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        service.connection()
    }
    
    /// Obtain user companions (must be logged in with access token), such as companion name, answers.
    ///
    /// - Parameters:
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important:Completion Handler is an any object which needs to be converted to **[TRPCompanionModel]** object.
    public func getUsersCompanions(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        getCompanionService()
    }
    
    internal func getCompanionService() {
        let service = TRPGetCompanionServices()
        service.completion = { result, error, pagination in
            self.genericParseAndPost([TRPCompanionModel].self, result, error, pagination)
        }
        service.connection()
    }
    
    private func companionPutPostService(id: Int? = nil, name: String, title: String?, answers: [Int]?, age:Int? = nil) {
        let service = TRPCompanionPutPostServices(companionId: id, name: name, answers: answers,title: title, age: age)
        service.completion = { result, error, pagination in
            self.genericParseAndPost(TRPCompanionModel.self, result, error, pagination)
        }
        service.connection()
    }
    
}

// MARK: - Favorites of User's Poi.
extension TRPRestKit {
    
    /// Add user's favorite Place of Interest.
    ///
    /// - Parameters:
    ///   - cityId: An Integer that refers to Id of city where the poi is located.
    ///   - poiId: A String that refers to Id of the given place.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPFavoritesInfoModel]** object.
    public func addUserFavorite(poiId: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(poiId: poiId, mode: .add)
    }
    
    /// Get user all favorite place of interests list
    ///
    /// - Parameters:
    ///   - cityId: An Integer that refers to Id of city where the poi is located.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPFavoritesInfoModel]** object.
    public func getUserFavorite(cityId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, mode: .get)
    }
    
    /// Delete user's favorite Place of Interest.
    ///
    /// - Parameters:
    ///   - cityId: An Integer that refers to Id of city where the poi is located.
    ///   - poiId: A String that refers to Id of the given place.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPParentJsonModel** object.
    public func deleteUserFavorite(favoriteId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(favoriteId: favoriteId, mode: .delete)
    }
    
    /// A services which will be used in users favorite place of interests, manages all task connecting to remote server.
    private func userFavoriteServices(cityId: Int? = nil, poiId: String? = nil, favoriteId: Int? = nil, mode: TRPUserFavorite.Mode) {
        
        var favoriteService: TRPUserFavorite?
        if mode == .add {
            if let poi = poiId {
                favoriteService = TRPUserFavorite(poiId: poi, type: mode)
            }
        } else if let cityId = cityId, mode == .get{
            favoriteService = TRPUserFavorite(cityId: cityId)
        } else if mode == .delete {
            if let fav = favoriteId {
                favoriteService = TRPUserFavorite(favoriteId: fav)
            }
        }
        
        guard let services = favoriteService else {return}
        services.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if mode == .delete {
                if let resultService = result as? TRPParentJsonModel {
                    self.postData(result: resultService)
                    return
                }
            } else {
                if let resultService = result as? TRPFavoritesJsonModel {
                    if mode == .add {
                        if let first = resultService.data?.first {
                            self.postData(result: first)
                        }else {
                            self.postData(result: resultService.data)
                        }
                        
                        return
                        
                    } else {
                        self.postData(result: resultService.data, pagination: pagination)
                        return
                    }
                }
            }
            
            self.postError(error: TRPErrors.wrongData as NSError)
        }
        services.connection()
    }
}

// MARK: - User Trips
extension TRPRestKit {
    
    /// Obtain the list of user trips with given limit, and completionHandler parameters.
    ///
    /// - Parameters:
    ///   - limit: An Integer value that refers to the number of trips which will be presented(Optional, default value is 100).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPUserTripInfoModel]** object.
    public func userTrips(limit: Int? = 100, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTripsServices(limit: limit ?? 100)
    }
    
    public func userTrips(from: String? = nil, to: String? = nil, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTripsServices(from: from, to: to, limit: 100)
    }
    
    /// A services which will be used in users trips, manages all task connecting to remote server.
    private func userTripsServices(from:String? = nil, to: String? = nil, limit: Int) {
        var tripService: TRPUserTripsServices?
        if let from = from {
            tripService = TRPUserTripsServices(from: from)
        }else if let to = to {
            tripService = TRPUserTripsServices(to: to)
        }
        
        if tripService == nil {
            tripService = TRPUserTripsServices()
        }
        
        tripService!.limit = limit
        tripService!.completion = { result, error, pagination in
            self.genericParseAndPost([TRPUserTripInfoModel].self, result, error, pagination)
        }
        tripService!.connection()
    }
    
}

// MARK: - User Timelines
extension TRPRestKit {
    
    /// Obtain the list of user timelines with given limit, and completionHandler parameters.
    ///
    /// - Parameters:
    ///   - limit: An Integer value that refers to the number of timelines which will be presented(Optional, default value is 100).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPUserTripInfoModel]** object.
    public func userTimelines(limit: Int? = 100, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTimelinesServices(limit: limit ?? 100)
    }
    
    public func userTimelines(from: String? = nil, to: String? = nil, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTimelinesServices(from: from, to: to, limit: 100)
    }
    
    /// A services which will be used in users timelines, manages all task connecting to remote server.
    private func userTimelinesServices(from:String? = nil, to: String? = nil, limit: Int) {
        var tripService: TRPUserTimelineServices?
        if let from = from {
            tripService = TRPUserTimelineServices(from: from)
        }else if let to = to {
            tripService = TRPUserTimelineServices(to: to)
        }
        
        if tripService == nil {
            tripService = TRPUserTimelineServices()
        }
        
        tripService!.limit = limit
        tripService!.completion = { result, error, pagination in
            self.genericParseAndPost([TRPTimelineModel].self, result, error, pagination)
        }
        tripService!.connection()
    }
    
}

