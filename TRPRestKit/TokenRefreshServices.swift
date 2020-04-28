//
//  TokenRefreshServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public class TokenRefreshServices {
    
    public typealias Handler = (_ token: String) -> Void
    
    public static var shared = TokenRefreshServices()
    
    private var services: [Handler] = []
    private var isFetching = false
    
    public func handler(isRefresh: Bool, _ handler: @escaping Handler) {
        
        guard let token = TRPUserPersistent.token() else {
            print("[Error 1]: Token Yok")
            handler("")
            return
        }
        
        if TRPUserPersistent.isTokenValid || isRefresh {
            handler(token)
            return
        }
        services.append(handler)
        print("Token zaman aşımında")
        fetchNewRefreshToken { (newToken) in
            
            for service in self.services {
                service(newToken)
            }
            self.services.removeAll()
            print("Tümü temizlendi")
        }
    }
 
    private func fetchNewRefreshToken(_ completion: @escaping(_ token: String) -> Void) {
        guard !isFetching else {return}
        isFetching = true
        print("-------------- YENİ TOKEN ÇEKİLİYOR")
        
        guard let refresh = TRPUserPersistent.fetchRefreshToken() else {return}
        
        TRPRestKit().refreshToken(refresh) { (_, error) in
            self.isFetching = false
            if let error = error {
                print("Refresh Error \(error.localizedDescription)")
                return
            }
            if let newToken = TRPUserPersistent.token() {
                completion(newToken)
            }else {
                print("New Refresh is Nil")
            }
        }
    }
    
}