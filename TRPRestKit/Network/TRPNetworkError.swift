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
    
    init?(json: JSON, link:String?) {
        if let status = json["status"] as? Bool {
            if status == false {
                guard let message = json["message"] as? JSON,
                    let description = message["description"] as? String,
                    let httpCode = message["http_code"] as? Int,
                    let code = message["code"] as? String else{
                        self = .undefined;
                        return nil;
                }
                var info = [String:Any]();
                info["description"] = description;
                info["httpCode"] = httpCode;
                info["code"] = code;
                if let link = link {
                    info["link"] = link;
                }
                self = .httpResult(code: httpCode, des: description, info:info)
                return;
            }
        }
        return nil;
    }
    
}
