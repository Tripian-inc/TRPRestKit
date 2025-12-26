//
//  TRPRestKit+POI.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Poi Categories Services
extension TRPRestKit {
    
    /// Obtain the list of all categories, such as attractions, restaurants, cafes, bars,
    /// religious places, cool finds, shopping centers, museums, bakeries and art galleries. Returned results include category ids.
    ///
    /// Poi Category is used during Add Place List operations (such as: Eat&Drink, Attractions, ...etc.).
    /// PoiCategory can be matched with **Place.categories**.
    ///
    /// - Parameters:
    ///     - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPCategoryInfoModel]** object.
    /// - See Also: [Api
    public func poiCategory(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        poiCategoryServices(id: nil)
    }
    
    /// A services which will be used in place of interests category services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///     - id: id of the Category (Optional).
    private func poiCategoryServices(id: Int?) {
        let poiService = TRPPoiCategoryService()
        poiService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            guard let serviceResult = result as? TRPPoiCategoryJsonModel, let types = serviceResult.data else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
                return
            }
            self.postData(result: types, pagination: pagination)
        }
        poiService.connection()
    }
}

// MARK: - Poi Services
extension TRPRestKit {
    
    
    public func poi(poiId: String,
                    completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        
        poiServices(poiId: poiId)
        
    }
    
    
    public func poi(cityId: Int,
                    search: String? = nil,
                    poiIds: [String]? = nil,
                    poiCategoies: [Int]? = nil,
                    mustTryIds: [Int]? = nil,
                    distance: Float? = nil,
                    bounds: LocationBounds? = nil,
                    limit: Int? = 25,
                    page: Int? = 1,
                    autoPagination: Bool = false,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        
        poiServices(cityId: cityId,
                    search: search,
                    poiIds: poiIds,
                    poiCategoies: poiCategoies,
                    mustTryIds: mustTryIds,
                    distance: distance,
                    bounds: bounds,
                    limit: limit,
                    page: page,
                    autoPagination: autoPagination)
        
    }
    
    public func poi(coordinate: TRPLocation,
                    cityId: Int? = nil,
                    search: String? = nil,
                    poiIds: [String]? = nil,
                    poiCategoies: [Int]? = nil,
                    mustTryIds: [Int]? = nil,
                    distance: Float? = nil,
                    bounds: LocationBounds? = nil,
                    limit: Int? = 25,
                    page: Int? = 1,
                    autoPagination: Bool = false,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        
        poiServices(cityId:cityId,
                    coordinate: coordinate,
                    search: search,
                    poiIds: poiIds,
                    poiCategoies: poiCategoies,
                    mustTryIds: mustTryIds,
                    distance: distance,
                    bounds: bounds,
                    limit: limit,
                    page: page,
                    autoPagination: autoPagination)
    }
    
    
    public func poi(url: String, limit: Int? = 25, page: Int? = 1, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        
        poiServices(url: url)
    }
    
    
    /// A services which will be used in place of interests services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///   - placeIds: Place id
    ///   - cities: cities Id
    ///   - limit:  number of record to display
    ///   - location: user current location
    ///   - distance: limit that location and distance between
    ///   - typeId: CategoryId
    ///   - typeIds: CategoriesIds
    ///   - url: url for Pagination
    ///   - searchText: Search text parameter for tags or places name
    ///   - cityId: CityId
    ///   - autoPagination: AutoCompletion patameter
    private func poiServices(poiId: String? = nil,
                             cityId: Int? = nil,
                             coordinate: TRPLocation? = nil,
                             search: String? = nil,
                             poiIds: [String]? = nil,
                             poiCategoies: [Int]? = nil,
                             mustTryIds: [Int]? = nil,
                             distance: Float? = nil,
                             bounds: LocationBounds? = nil,
                             limit: Int? = 25,
                             page: Int? = 1,
                             autoPagination: Bool = false,
                             url: String? = nil
    ) {
        
        var services: TRPPoiService?
        if let poiId = poiId {
            services = TRPPoiService(poiId: poiId)
        }else if let coordinate = coordinate {
            services = TRPPoiService(coordinate: coordinate)
        }else if let cityId = cityId {
            services = TRPPoiService(cityId: cityId)
        }else if url != nil {
            services = TRPPoiService()
        }
        
        guard let service = services else {return}
        service.cityId = cityId
        service.bounds = bounds
        service.coordinate = coordinate
        service.distance = distance
        service.searchText = search
        service.placeIds = poiIds
        service.mustTryIds = mustTryIds
        service.poiCategories = poiCategoies
        service.limit = limit ?? 25
        service.page = page ?? 1
        
        
        service.isAutoPagination = autoPagination
        service.completion = {    (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPPoiJsonModel {
                if let places = serviceResult.data {
                    self.postData(result: places, pagination: pagination)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        
        if let link = url {
            service.connection(link)
        } else {
            service.connection()
        }
    }
    
    
    
}

