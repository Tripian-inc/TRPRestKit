//
//  TRPUserRegister.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 11.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import Foundation
public class TRPUserRegister: TRPRestServices{
    
    
    public enum UserStatus {
        case create, update, delete
    }
    
    var status: UserStatus = .create
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var oaut: String?
    var userId: Int?
    
    
    /// Create New User
    ///
    /// - Parameters:
    ///   - firstName: User Name
    ///   - lastName: User Last Name
    ///   - email: User email adress
    ///   - password: user password
    public init(firstName: String,
                lastName:String,
                email: String,
                password: String) {
        status = .create
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    /// UPDATE USER INFORMATION
    public init(id:Int,
                firstName: String,
                lastName: String,
                password:String) {
        status = .update
        self.userId = id
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
    
    /// Delete User
    public init(oauth: String,
                id:Int) {
        status = .delete
        self.oaut = oauth
        self.userId = id
    }
    
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.Completion?(nil,error, nil);
            return
        }
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let json = String(data: data, encoding: .utf8)
        print("UserJsonResult: \(json!)");
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPUserMeJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.Completion?(result, nil, pag);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params: [String:Any] = [:]
        
        if status == .create ||  status == .update{
            params["first_name"] = firstName ?? ""
            params["last_name"] = lastName ?? ""
            params["email"] = email ?? ""
            params["password"] = password ?? ""
        }
        
        return params
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.Register.link;
        if status == .update || status == .delete {
            if userId == nil {
                fatalError("User ID Is Nil")
            }
            path += "/\(userId ?? 0)"
        }
        return path;
    }
    
    public override func oauth() -> String? {
        return oaut
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    public override func requestMode() -> TRPRequestMode {
        if status == .update {
            return TRPRequestMode.put
        }else if status == .delete {
            return TRPRequestMode.delete
        }
        return TRPRequestMode.post
    }
}
