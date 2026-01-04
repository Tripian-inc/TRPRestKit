//
//  TRPRestKit+Google.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Google Auto Complete
extension TRPRestKit {
    
    /// Obtain google place list with given key, text, centerForBoundary,  radiusForBoundary and completion parameters.
    ///
    /// - Parameters:
    ///    - key: A String value that refers to the API Key of Google.
    ///    - text: A String value that refers to search term.
    ///    - center: A TRPLocation object that refers to boundary of City.
    ///    - radius: A Double value which refers to radius for the search area limit.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPGooglePlace]** object.
    public func googleAutoComplete(key: String,
                                   text: String,
                                   centerForBoundary center: TRPLocation? = nil,
                                   radiusForBoundary radius: Double? = nil,
                                   completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googlePlaceAutoCompleteService(key: key,
                                       text: text,
                                       centerForBoundary: center,
                                       radiusForBoundary: radius)
    }
    
    public func googleAutoComplete(key: String,
                                   text: String,
                                   boundarySW: TRPLocation?,
                                   boundaryNE: TRPLocation?,
                                   completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googlePlaceAutoCompleteService(key: key,
                                       text: text,
                                       boundarySW: boundarySW,
                                       boundaryNE: boundaryNE)
    }
    
    /// A services which will be used in google place auto complete services, manages all task connecting to remote server.
    private func googlePlaceAutoCompleteService(key: String,
                                                text: String,
                                                centerForBoundary center: TRPLocation? = nil,
                                                boundarySW: TRPLocation? = nil,
                                                boundaryNE: TRPLocation? = nil,
                                                radiusForBoundary radius: Double? = nil) {
        let autoCOmpleteService = TRPGoogleAutoComplete(key: key, text: text)
        autoCOmpleteService.centerLocationForBoundary = center
        autoCOmpleteService.radiusForBoundary = radius
        autoCOmpleteService.boundarySW = boundarySW
        autoCOmpleteService.boundaryNE = boundaryNE
        autoCOmpleteService.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let data = data as? [TRPGooglePlace] {
                self.postData(result: data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
    }
    
}

// MARK: - Google Place
extension TRPRestKit {
    
    ///  Obtain infromation of a place from Google Server with given key, placeId and completion parameters.
    ///
    ///  This function does not require to use Tripian Server. //TODO: Bunu yazmak dogrumu?
    ///
    /// - Parameters:
    ///    - key: A String value that refers to the API Key of Google.
    ///    - id: An Integer value which refers to the Id of Place that registered in Google.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPGooglePlaceLocation** object.
    public func googlePlace(key: String, id: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googlePlaceServices(key: key, placeId: id)
    }
    
    /// A services which will be used in google place services, manages all task connecting to remote server.
    private func googlePlaceServices(key: String, placeId: String) {
        let googlePlaceService = TRPGooglePlaceService(key: key, placeId: placeId)
        googlePlaceService.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let result = data as? TRPGooglePlaceLocation {
                self.postData(result: result)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
    }
    
}

// MARK: - Google Geocoding
extension TRPRestKit {
    
    ///  Obtain infromation of a place from Google Server with given key, placeId and completion parameters.
    ///
    ///  This function does not require to use Tripian Server. //TODO: Bunu yazmak dogrumu?
    ///
    /// - Parameters:
    ///    - key: A String value that refers to the API Key of Google.
    ///    - id: An Integer value which refers to the Id of Place that registered in Google.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPGooglePlaceLocation** object.
    public func googleGeocoding(location: TRPLocation, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googleGeocodingServices(location: location)
    }
    
    /// A services which will be used in google place services, manages all task connecting to remote server.
    private func googleGeocodingServices(location: TRPLocation) {
        let googlePlaceService = TRPGoogleGeocodingService(location: location)
        googlePlaceService.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let result = data as? String {
                self.postData(result: result)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
    }
    
}

