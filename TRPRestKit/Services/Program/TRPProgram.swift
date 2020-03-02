//
//  TRPProgram.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProgram: TRPRestServices<TRPGenericParser<TRPTripModel>> {
    
    var setting: TRPTripSettings?
    
    internal override init() {}
    
    internal init(setting: TRPTripSettings) {
        self.setting = setting
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder()
        
        do {
            let result = try jsonDecode.decode(TRPGenericParser<TRPTripModel>.self, from: data)
            let pag = paginationController(parentJson: result)
            self.completion?(result, nil, pag)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func path() -> String {
        var link = TRPConfig.ApiCall.trip.link
        if let hash = setting?.hash {
            link += "/\(hash)"
        }
        return link
    }
    
    override func requestMode() -> TRPRequestMode {
        if setting?.hash != nil {
            return .put
        }
        return TRPRequestMode.post
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    public override func bodyParameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        
        guard let setting = setting else {
            return params
        }
        
        //Edit
        if let hash = setting.hash {
            params["hash"] = hash
        } else {//Create
            params["city_id"] = setting.cityId
        }
        //TODO: - birleşitirlecek
        print("")
        print("----")
        print(createNewTime(setting.arrivalTime))
        print("----")
        print("")
        params["arrival_datetime"] = createNewTime(setting.arrivalTime)
        params["departure_datetime"] = createNewTime(setting.departureTime)
        params["number_of_adults"] = String(setting.adultsCount)
        
        
        if let children = setting.childrenCount {
            params["number_of_children"] = String(children)
        }
        
        params["answers"] = setting.getAllAnswers()
        
        if let coord = setting.coordinate {
            params["coordinate"] = "{\"lat\":\(coord.lat),\"lng\"\(coord.lon)}"
        }
        if let accommodationAddress = setting.accommodationAdress {
            params["accommodation_address"] = accommodationAddress
        }
        
        if let companions = setting.selectedCompanionIds {
            params["companion_ids"] = companions.map {"\($0)"}.joined(separator: ",")
        }

        if let pace = setting.pace {
            params["pace"] = pace
        }
        
        let gen = setting.doNotGenerate == true ? 1 : 0
        
        params["do_not_generate"] = gen
        
        return params
    }
    
    func createNewTime(_ time:TRPTime) -> String {
        return "\(time.date)T\(time.time)Z"
    }
    
}
