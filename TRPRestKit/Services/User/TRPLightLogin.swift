//
//  TRPGuestLogin.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 21.08.2024.
//  Copyright © 2024 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPLightLogin: TRPRestServices<TRPLoginJsonModel>  {
    private var uniqueId: String
    private var firstName: String?
    private var lastName: String?
    
    private var device: TRPDevice?
    
    public init(uniqueId: String,
                firstName: String?,
                lastName: String?,
                device: TRPDevice? = nil) {
        self.uniqueId = uniqueId
        self.firstName = firstName
        self.lastName = lastName
        self.device = device
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
            let result = try jsonDecode.decode(TRPLoginJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.completion?(result, nil, pag)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func bodyParameters() -> [String: Any]? {
        
        var parameters: [String: Any] = [:]
        parameters["uniqueId"] = uniqueId
        
        if let firstName {
            parameters["firstName"] = firstName
        }
        
        if let lastName {
            parameters["lastName"] = lastName
        }
        
        if let device = device, let deviceParams = device.params() {
            parameters["device"] = deviceParams
        }
        return parameters
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.lightLogin.link
    }
}
