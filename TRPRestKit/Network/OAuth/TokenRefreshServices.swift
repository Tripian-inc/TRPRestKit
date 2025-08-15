//
//  TokenRefreshServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public class TokenRefreshServices {
    
    public typealias Handler = (_ token: String?, _ error: TRPErrors?) -> Void
    
    public static var shared = TokenRefreshServices()
    
    private var services: [Handler] = []
    private var isFetching = false
    
    public func handler(isRefresh: Bool, _ handler: @escaping Handler) {
        
        guard let token = TripianTokenController().token else {
            handler("", nil)
            return
        }
        
        if TripianTokenController().isTokenValid || isRefresh {
            handler(token, nil)
            return
        }
        
        services.append(handler)
        print("Token zaman aşımında")
        fetchNewRefreshToken { (newToken, error) in
            for service in self.services {
                service(newToken, error)
            }
            self.services.removeAll()
        }
        
    }
 
    public func fetchNewRefreshToken(_ completion: @escaping(_ token: String?, _ error: TRPErrors?) -> Void) {
        guard !isFetching else {return}
        isFetching = true
        print("-------------- YENİ TOKEN ÇEKİLİYOR")
        
        guard let refresh = TripianTokenController().refreshToken else {return}
        
        TRPRestKit().refreshToken(refresh) { (_, error) in
            self.isFetching = false
            if let error = error {
                completion(nil, TRPErrors.refreshTokenError)
                print("Refresh Error \(error.localizedDescription)")
                return
            }
            if let newToken = TripianTokenController().token {
                completion(newToken, nil)
            }else {
                print("New Refresh is Nil")
            }
        }
    }
    
}
