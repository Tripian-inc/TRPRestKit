//
//  TRPRestKit.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 22.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//
//
import Foundation
import TRPFoundationKit

let log = TRPLogger(prefixText: "Tripian/TRPRestKit")

/// The TRPRestKit is a framework that provides access Tripian Api.
///
///  Framework provide you;
///  * Retrieve personal infromation of the given user
///  * Information of City
///  * Type of Cİty
///  * Information of Place
///  * Question of trip
///  * Take a recommendation
///  * User login/register/info
///  * User's trip
///  * Daily Plan
///  * Plan's place
///  * Travel details
///  * NearBy services, and more.
///
/// - See Also: [How to use](https://github.com/Tripian-inc/TRPRestKit)
///
///
/// ```
/// 
///     TRPClient.start(enviroment: .test, apiKey: <#yourApiKey>)
///
///     TRPRestKit().city(withId:completion:)
///
/// ```
///
/// A `TRPRestKit()` object  defines a single object that user can follow to operate below functions.
/// Typically you do not create instances of this class directly,
/// instead you receive object in completion handler form when you request a call
/// such as `TRPRestKit().city(withId:completion:)` method. However assure that you have provided tripian api key first.
///
// swiftlint:disable all
public class TRPRestKit {
    
    /// **CompletionHandler** is a typealias that provides result and error when the request is completed.
    /// - Parameters:
    ///   - result: Any Object that will be returned when the result comes.
    ///   - error: NSError that will be returned when there is an error.
    public typealias CompletionHandler = (_ result: Any?, _ error: NSError?) -> Void
    
    /// **CompletionHandlerWithPagination** is a typealias that provides result and error and pagination when the request is completed.
    /// - Parameters:
    ///   - result: Any Object that will be returned when the result comes.
    ///   - error: NSError that will be returned when there is an error.
    ///   - pagination: Pagination object that will be returned to give whether requested operation is completed or continued.
    public typealias CompletionHandlerWithPagination = (_ result: Any?, _ error: NSError?, _ pagination: Pagination?) -> Void
    
    internal var completionHandler: CompletionHandler?
    internal var completionHandlerWithPagination: CompletionHandlerWithPagination?
    private(set) var queue: DispatchQueue = .main
    
    
    internal func postData(result: Any?, pagination: Pagination? = Pagination.completed) {
        queue.async {
            if let comp = self.completionHandler {
                comp(result, nil)
            } else if let withPagination = self.completionHandlerWithPagination {
                withPagination(result, nil, pagination)
            }
        }
    }
    
    internal func postError(error: NSError?, pagination: Pagination? = Pagination.completed) {
        queue.async {
            if let error = error, error.description.contains("is expired") {
                return
            }
            if let comp = self.completionHandler {
                comp(nil, error)
            } else if let full = self.completionHandlerWithPagination {
                full(nil, error, pagination)
            }
        }
    }
    
    internal func parseAndPost<T: Decodable>(_ parser: T.Type, _ result: Any?, _ error: NSError?, _ pagination: Pagination?) {
        if let error = error {
            self.postError(error: error)
            return
        }
        if let serviceResult = result as? T{
            self.postData(result: serviceResult)
        }else {
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
    }
    
    internal func genericParseAndPost<T: Decodable>(_ parser: T.Type, _ result: Any?, _ error: NSError?, _ pagination: Pagination?) {
        if let error = error {
            self.postError(error: error)
            return
        }
        if let serviceResult = result as? TRPGenericParser<T>, let data = serviceResult.data{
            self.postData(result: data)
        }else {
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
    }
    
    
    public init(queue: DispatchQueue = .main) {
        self.queue = queue
    }
    
}

