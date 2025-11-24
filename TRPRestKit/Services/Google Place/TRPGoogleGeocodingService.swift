//
//  TRPGooglePlaceService.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 5.02.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit

class TRPGoogleGeocodingService {
    
    private var key: String = ""
    private var location: TRPLocation
    
    init(location: TRPLocation) {
        self.location = location
        
        if let key = TRPApiKeyController.getKey(TRPApiKeys.trpGooglePlace) {
            self.key = key
        }
    }
    
    func start(completion: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        if key.isEmpty {
            completion(nil, TRPErrors.someThingWronk("Google API Key is empty") as NSError)
            return
        }
        let network = TRPNetwork(link: "https://maps.googleapis.com/maps/api/geocode/json")
        network.add(params: ["latlng": "\(location.lat),\(location.lon)", "key": key])
        network.add(mode: .post)
        network.addValue(Bundle.main.bundleIdentifier ?? "com.tripian.TripianOne", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        network.build { (error, data) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                let object: NSDictionary?
                do {
                    object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                } catch {
                    object = nil
                    completion(nil, TRPErrors.wrongData as NSError)
                    return
                }
                if let errorMessage = object?["error_message"] as? String {
                    completion(nil, TRPErrors.someThingWronk(errorMessage) as NSError)
                    return
                }
                guard let results = object?["results"] as? [[String: Any]],
                      let firstResult = results.first,
                      let formattedAddress = firstResult["formatted_address"] as? String
                    else {
                        completion(nil, TRPErrors.wrongData as NSError)
                        return
                }
                
                completion(formattedAddress, nil)
            }
        }
        
    }
    
}
