//
//  TRPGoogleAutoComplete.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 5.02.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
class TRPGoogleAutoComplete {
    
    private var key: String
    private var text: String
    
    
    init(key: String, text: String) {
        self.key = key
        self.text = text
    }
    
    func start(completion: @escaping (_ result:Any?, _ error:NSError?) -> Void) {
        //https://maps.googleapis.com/maps/api/
        //https://maps.googleapis.com/maps/api/place/autocomplete/json
        let network = TRPNetwork(link: "https://maps.googleapis.com/maps/api/place/autocomplete/json")
        network.add(params: ["input":text, "key":key])
        network.add(mode: .post)
        network.build { (error, data) in
            if let error = error {
                print("Google Place Api Error \(error.localizedDescription)")
                completion(nil,error)
                return
            }
            if let data = data {
                let object: NSDictionary?
                do {
                    object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                } catch {
                    object = nil
                    print("GooglePlaces Error")
                    return
                }
                if let errorMessage = object?["error_message"] as? String {
                    print("HATA \(errorMessage)")
                    completion(nil,TRPErrors.someThingWronk(errorMessage) as NSError)
                    return
                }
                
                guard let predictions = object?["predictions"] as? [[String: Any]] else { return }
                let sonuc = predictions.map { TRPGooglePlace(prediction: $0) }
                completion(sonuc,nil)
            }
        }
    }
}

