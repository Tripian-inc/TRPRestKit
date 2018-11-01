//
//  TRPNetworkError.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
//Move
public enum TRPErrors:Error{
    case undefined
    case httpResult(code:Int, des:String, info: [String:Any]);
    case wrongData
    case emptyData
    case emptyDataOrParserError
    case objectIsNil(name:String)
}

extension TRPErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .httpResult(_, let message,_):
            return NSLocalizedString(message, comment: "");
        case .undefined:
            return NSLocalizedString("Undefined error", comment: "");
        case .wrongData:
            return NSLocalizedString("Wrong Data", comment: "");
        case .emptyData:
            return NSLocalizedString("Empty Data", comment: "");
        case .emptyDataOrParserError:
            return NSLocalizedString("Empty data or couldn't parse json", comment: "");
        case .objectIsNil(let name):
            return NSLocalizedString("\(name) is a nil", comment: "");
        }
    }
}

extension TRPErrors: CustomNSError {
    
    public static var errorDomain: String {
        return "com.tripian.TRPClientError";
    }
    
    public var errorCode: Int {
        switch self {
        case .httpResult(let code,_,_):
            return code
        default:
            return 999
        }
    }
    public var errorUserInfo: [String : Any]{
        switch self {
        case .httpResult(_, _, let info):
            return info
        default:
            return [:];
        }
    }
    
}

extension TRPErrors {
    // TODO: - Unit test must write
    init?(json: JSON, link:String?) {
        if let status = json["success"] as? Bool {
            if status == false {
                guard let message = json["message"] as? String,
                    let status = json["status"] as? Int else{
                        self = .undefined;
                        return nil;
                }
                var info = [String:Any]();
                info["description"] = message;
                info["code"] = status;
                if let link = link {
                    info["link"] = link;
                }
                self = .httpResult(code: status, des: message, info:info)
                return;
            }
        }
        return nil;
    }
    
}
