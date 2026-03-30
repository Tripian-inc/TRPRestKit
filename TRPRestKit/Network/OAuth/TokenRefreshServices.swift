//
//  TokenRefreshServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation

public extension Notification.Name {
    static let trpTokenInvalidated = Notification.Name("trpTokenInvalidated")
}

public class TokenRefreshServices {
    
    public typealias Handler = (_ token: String?, _ error: TRPErrors?) -> Void
    
    public static var shared = TokenRefreshServices()
    
    private var services: [Handler] = []
    private var isFetching = false
    private var lastRefreshFailed = false
    private var lastFailureTime: Date?
    private let retryDelay: TimeInterval = 60
    private var retryCount = 0
    private let maxRetries = 3
    
    public func handler(isRefresh: Bool, _ handler: @escaping Handler) {
        
        guard let token = TripianTokenController().token else {
            handler("", nil)
            return
        }
        
        if TripianTokenController().isTokenValid || isRefresh {
            handler(token, nil)
            return
        }

        if lastRefreshFailed, let failureTime = lastFailureTime {
            if Date().timeIntervalSince(failureTime) < retryDelay {
                handler(nil, TRPErrors.refreshTokenError)
                return
            }
            lastRefreshFailed = false
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
        guard !isFetching else { return }
        isFetching = true
        print("-------------- YENİ TOKEN ÇEKİLİYOR (Attempt \(retryCount + 1)/\(maxRetries))")

        guard let refresh = TripianTokenController().refreshToken else {
            isFetching = false
            clearTokenAndNotify()
            completion(nil, TRPErrors.refreshTokenInvalid)
            return
        }

        TRPRestKit().refreshToken(refresh) { (_, error) in
            self.isFetching = false

            if let error = error {
                print("Refresh Error: \(error.localizedDescription)")

                if self.isFatalAuthError(error) {
                    // 401/403 - Token is permanently invalid, don't retry
                    print("Fatal auth error detected, clearing token")
                    self.clearTokenAndNotify()
                    self.retryCount = 0
                    completion(nil, TRPErrors.refreshTokenInvalid)
                    return
                }

                // Transient error (network/server) - retry with exponential backoff
                self.retryCount += 1
                if self.retryCount < self.maxRetries {
                    let delay = pow(2.0, Double(self.retryCount)) // 2, 4, 8 seconds
                    print("Retrying refresh in \(delay) seconds...")
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.fetchNewRefreshToken(completion)
                    }
                } else {
                    // Max retries exhausted
                    print("Max refresh retries exhausted, clearing token")
                    self.clearTokenAndNotify()
                    self.retryCount = 0
                    self.lastRefreshFailed = true
                    self.lastFailureTime = Date()
                    completion(nil, TRPErrors.refreshTokenExhausted)
                }
                return
            }

            // Success
            if let newToken = TripianTokenController().token {
                self.retryCount = 0
                self.lastRefreshFailed = false
                self.lastFailureTime = nil
                completion(newToken, nil)
            } else {
                self.lastRefreshFailed = true
                self.lastFailureTime = Date()
                print("New Refresh is Nil")
                completion(nil, TRPErrors.refreshTokenError)
            }
        }
    }

    private func isFatalAuthError(_ error: Error) -> Bool {
        if let trpError = error as? TRPErrors {
            let code = trpError.errorCode
            return code == 401 || code == 403
        }
        if let nsError = error as NSError? {
            return nsError.code == 401 || nsError.code == 403
        }
        return false
    }

    private func clearTokenAndNotify() {
        TripianTokenController().clearToken()
        lastRefreshFailed = true
        lastFailureTime = Date()
        NotificationCenter.default.post(name: .trpTokenInvalidated, object: nil)
    }

    public func resetFailureState() {
        lastRefreshFailed = false
        lastFailureTime = nil
        retryCount = 0
    }

}
