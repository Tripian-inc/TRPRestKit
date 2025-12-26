//
//  TRPRestKit+City.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Cities Services
extension TRPRestKit {
    /// Obtain the list of all available cities with given limit, isAutoPagination(Optional) and completionHandler parameters.
    ///
    /// - Parameters:
    ///     - limit: Number of city that will be given.
    ///     - isAutoPagination: Boolean value whether pagination is required, default value is true.
    ///     - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPCityInfoModel]** object.
    public func cities(limit: Int? = nil, isAutoPagination: Bool? = true, completion: @escaping CompletionHandlerWithPagination) {
        //Fixme: - autoPagination eklenebilir.
        self.completionHandlerWithPagination = completion
        citiesServices(id: nil, limit: limit, autoPagination: isAutoPagination)
    }
    
    /// Obtain the list of all available shorex cities with given limit, isAutoPagination(Optional) and completionHandler parameters.
    ///
    /// - Parameters:
    ///     - limit: Number of city that will be given.
    ///     - isAutoPagination: Boolean value whether pagination is required, default value is true.
    ///     - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPCityInfoModel]** object.
    public func shorexCities(completion: @escaping CompletionHandlerWithPagination) {
        //Fixme: - autoPagination eklenebilir.
        self.completionHandlerWithPagination = completion
        citiesServices(isShorex: true)
    }
    
    /// Obtain the requested city with given cityId and completion parameters.
    ///
    /// Obtain information (such as ) on a specific city. Returned results include city_id, featured image, coordinates, country and continent.
    ///
    /// - Parameters:
    ///     - id: City Id that will be the id of required city.
    ///     - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPCityInfoModel** object.
    public func city(with id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        citiesServices(id: id)
    }
    
    /// Obtain the requested city with given user location and completionHandler parameters.
    ///
    /// The nearest city is found by requested location will be returned. Returned results include city_id, featured image, coordinates, country and continent.
    ///
    /// - Parameters:
    ///   - location: TRLocation object that will be given.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPCityInfoModel** object.
    public func city(with location: TRPLocation, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        citiesServices(location: location)
    }
    
    public func cityInformation(with id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        createCityInformationServices(id: id)
    }
    
    public func cityEvents(with id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        citiesServices(id: id, isEvents: true)
    }
    
    /// Obtain the list of all available cities with given url and completion parameters.
    ///
    /// All the available cities from the requested url will be given in the form of CompletionHandlerWithPagination.
    ///
    /// - Parameters:
    ///   - url: url that returned from Pagination
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPCityInfoModel]** object.
    public func cities(url: String, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        citiesServices(id: nil, url: url)
    }
    
    /// A services which will be used in cities services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///   - id: Id of the city (Optional).
    ///   - url: url that will be returned from Pagination (Optional).
    ///   - location: User's current location (Optional).
    ///   - limit: number of city list to display (Optional).
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional).
    private func citiesServices(id: Int? = nil,
                                url: String? = nil,
                                location: TRPLocation? = nil,
                                limit: Int? = nil,
                                autoPagination: Bool? = true,
                                isShorex: Bool = false,
                                isInformation: Bool = false,
                                isEvents: Bool = false) {
        
        let cityService = createCitiesServices(id: id, link: url, location: location, limit: limit, autoPagination: autoPagination, isShorex: isShorex, isInformation: isInformation, isEvents: isEvents)
        guard let service = cityService else {return}
        if let autoPagination = autoPagination {
            service.isAutoPagination = autoPagination
        }
        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPCityJsonModel {
                if let cities = serviceResult.data {
                    if id != nil || location != nil {
                        if let city = cities.first {
                            self.postData(result: city, pagination: pagination)
                            return
                        }
                    } else {
                        self.postData(result: cities, pagination: pagination)
                        return
                    }
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
    
    private func createCitiesServices(id: Int? = nil,
                                      link: String? = nil,
                                      location: TRPLocation? = nil,
                                      limit: Int? = 1000,
                                      autoPagination: Bool? = true,
                                      isShorex: Bool = false,
                                      isInformation: Bool = false,
                                      isEvents: Bool = false) -> TRPCities? {
        var cityService: TRPCities?
        if id == nil && location == nil && link == nil {
            cityService = TRPCities()
        } else if let id = id {
            cityService = TRPCities(cityId: id, isInformation: isInformation, isEvents: isEvents)
        } else if let location = location {
            cityService = TRPCities(location: location)
        } else if limit != nil {
            cityService = TRPCities()
        }
        cityService?.limit = limit
        if isShorex {
            cityService?.setForShorex()
        }
        return cityService
    }
    
    private func createCityInformationServices(id: Int) {
        let cityService = TRPCityInformation(cityId: id)
        cityService.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPGenericParser<TRPCityInformationDataJsonModel> {
                if let data = serviceResult.data {
                    self.postData(result: data)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        
        cityService.connection()
    }
    
}

