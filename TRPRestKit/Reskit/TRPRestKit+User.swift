//
//  TRPRestKit+User.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - USER
// MARK: Login
extension TRPRestKit {
    
    /// Obtain the access token for API calls that require user identification.
    /// When login operation is successful, TRPUserPersistent object is saved in user accessToken.
    ///
    ///
    /// - Parameters:
    ///   - userName: Username of the user
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPLoginInfoModel** object.
    public func login(withUserName userName: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        let params = ["username": userName]
        loginServices(parameters: params)
    }
    
    /// Obtain the access token for API calls that require user identification.
    /// When login operation is successful, TRPUserPersistent object is saved in user accessToken.
    ///
    ///
    /// - Parameters:
    ///   - parameters: Custom user parameters such as ["username": "abcd", "password":"1234"], it depend on server type.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPLoginInfoModel** object.
    public func login(with parameters: [String: String], completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(parameters: parameters)
    }
    
    public func login(withEmail email: String,
                      password: String,
                      device: TRPDevice? = nil,
                      completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        var params = [String: Any]()
        params["email"] = email
        params["password"] = password
        var _device: TRPDevice
        if device == nil {
            _device = TRPDevice()
        } else {
            _device = device!
        }
        params["device"] = _device.params()
        loginServices(parameters: params)
    }
    
    private func loginServices(parameters: [String: Any]) {
        let loginService: TRPLogin? = TRPLogin(parameters: parameters)
        guard let service = loginService else {return}
        service.completion = {    (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPGenericParser<TRPLoginInfoModel> {
                if let data = serviceResult.data {
                    self.saveToken(TRPToken(login: data))
                }
                self.postData(result: serviceResult.data, pagination: pagination)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        service.connection()
    }
    
    /// User logout. TRPUserPersistent removes all accessToken.
    public func logout(completion: @escaping CompletionHandler) {
        completionHandler = completion
        logoutService()
    }
    
    private func logoutService() {
        let logoutService = TRPLogOutServices()
        logoutService.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPParentJsonModel {
                TRPUserPersistent.remove()
                self.postData(result: serviceResult, pagination: pagination)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        logoutService.connection()
    }
    
}

// MARK: Guest Login
extension TRPRestKit {
    public func guestLogin(firstName: String,
                           lastName: String,
                           email: String,
                           password: String,
                           device: TRPDevice? = nil,
                           completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        var _device = device
        if device == nil {
            _device = TRPDevice()
        }
        guestLoginServices(email: email, password: password, firstName: firstName, lastName: lastName, device: _device)
    }
    
    private func guestLoginServices(email: String,
                                    password: String,
                                    firstName: String,
                                    lastName: String,
                                    device: TRPDevice? = nil) {
        let services = TRPGuestLogin(email: email,
                                     password: password,
                                     firstName: firstName,
                                     lastName: lastName,
                                     device: device)
        
        services.completion = { (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let registerResult = result as? TRPLoginJsonModel {
                self.saveToken(TRPToken(login: registerResult.data))
                self.postData(result: registerResult.data)
            }else if let serviceResult = result as? TRPTestUserInfoJsonModel {
                self.postData(result: serviceResult.data)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services.connection()
    }
}

// MARK: Light Login
extension TRPRestKit {
    public func lightLogin(uniqueId: String,
                           firstName: String? = nil,
                           lastName: String? = nil,
                           device: TRPDevice? = nil,
                           completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        var _device = device
        if device == nil {
            _device = TRPDevice()
        }
        lightLoginServices(uniqueId: uniqueId, firstName: firstName, lastName: lastName, device: _device)
    }
    
    private func lightLoginServices(uniqueId: String,
                                    firstName: String? = nil,
                                    lastName: String? = nil,
                                    device: TRPDevice? = nil) {
        let services = TRPLightLogin(uniqueId: uniqueId,
                                     firstName: firstName,
                                     lastName: lastName,
                                     device: device)
        
        services.completion = { (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let registerResult = result as? TRPLoginJsonModel {
                self.saveToken(TRPToken(login: registerResult.data))
                self.postData(result: registerResult.data)
            }else if let serviceResult = result as? TRPTestUserInfoJsonModel {
                self.postData(result: serviceResult.data)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services.connection()
    }
}

// MARK: Social Login
extension TRPRestKit {
    public func socialLogin(device: TRPDevice? = nil,
                            completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        var params = [String: Any]()
        if let device = device, let deviceParams = device.params() {
            params["device"] = deviceParams
        }
        socialLoginServices(parameters: params)
        
    }
    
    private func socialLoginServices(parameters: [String: Any]) {
        let socialLoginService: TRPSocialLogin? = TRPSocialLogin(parameters: parameters)
        guard let service = socialLoginService else {return}
        service.completion = {    (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPGenericParser<TRPSocialLoginInfoModel> {
                TRPUserPersistent.saveSocialLogin()
                self.postData(result: serviceResult.data, pagination: pagination)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        service.connection()
    }
}

// MARK: User Register
extension TRPRestKit {
    
    /// Create a new user (customer) by posting the required parameters indicated below. No extra step needed to active the new user.
    /// Tripian Api generates a `userName` automatically refer to user's email address.
    ///
    /// - Parameters:
    ///   - email: Username of the user which usually refers to email address of the user.
    ///   - password: Password of the user.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPRegisterUserInfo** object.
    public func register(userName: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
//        userRegisterServices(userName: userName)
    }
    
    //RETURN TRPUserInfoModel
    public func register(email: String,
                         password: String,
                         firstName: String,
                         lastName: String,
                         age: Int? = nil,
                         answers: [Int]? = nil,
                         dateOfBirth: String? = nil,
                         device: TRPDevice? = nil,
                         completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(email: email, password: password, firstName: firstName, lastName: lastName, age: age, answers: answers, dateOfBirth: dateOfBirth, device: device)
    }
    
    /// Obtain personal user information (must be logged in with access token), such as user id, e-mail, and preferences.
    ///
    /// - Parameters:
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPUserInfoModel** object.
    public func userInfo(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userInfoServices(type: .getInfo)
    }
    
    /// A services which will be used in user register services, manages all task connecting to remote server.
    
    private func userRegisterServices(email: String,
                                      password: String,
                                      firstName: String,
                                      lastName: String,
                                      age: Int? = nil,
                                      answers: [Int]? = nil,
                                      dateOfBirth: String? = nil,
                                      device: TRPDevice? = nil) {
//        var services: TRPUserRegister?
//        if userName != nil {
//            services = TRPUserRegister(userName: userName)
//        }else if let email = email, let password = password {
        let services = TRPUserRegister(email: email,
                                       password: password,
                                       firstName: firstName,
                                       lastName: lastName,
                                       answers: answers,
                                       age: age,
                                       dateOfBirth: dateOfBirth,
                                       device: device)
//        }
        
//        guard let mServices = services else { return }
        services.completion = { (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let registerResult = result as? TRPLoginJsonModel {
                self.saveToken(TRPToken(login: registerResult.data))
                self.postData(result: registerResult.data)
            }else if let serviceResult = result as? TRPTestUserInfoJsonModel {
                self.postData(result: serviceResult.data)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services.connection()
    }
    
}

// MARK: Refresh Token
extension TRPRestKit {
    public func refreshToken(_ refreshToken: String, device: TRPDevice? = nil, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        refreshTokenService(refreshToken, device: device)
    }
    ///RETURN TRPRefreshTokenInfoModel
    private func refreshTokenService(_ refreshToken: String, device: TRPDevice? = nil) {
        let service = TRPRefreshTokenService(refreshToken: refreshToken, device: device)
        service.completion = {result, error, _ in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let result = result as? TRPGenericParser<TRPRefreshTokenInfoModel>, let data = result.data {
                
                var tokenInfo = TRPToken(refresh: data)
                tokenInfo.refreshToken = refreshToken
                self.saveToken(tokenInfo)
                self.postData(result: data)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        service.connection()
    }
}

// MARK: Update User Info
extension TRPRestKit {
    
    /// Update user information (must be logged in with access token), such as user id, e-mail, and preferences.
    /// So that, the updated answers will effect the recommendation engine's work upon user's preferences.
    /// After updating user info, future trips of the user will be affected.
    ///
    /// - Parameters:
    ///   - firstName: A String which refers to first name of the user (Optional).
    ///   - lastName: A String which refers to last name of the user (Optional).
    ///   - age: An Integer which refers to age of the user (Optional).
    ///   - answers: An Integer array which refers to User preferences (Optional).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPUserInfoModel** object.
    public func updateUserInfo(firstName: String? = nil,
                               lastName: String? = nil,
                               password: String? = nil,
                               currentPassword: String? = nil,
                               dateOfBirth: String? = nil,
                               answers: [Int]? = nil,
                               completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(firstName: firstName,
                         lastName: lastName,
                         dateOfBirth: dateOfBirth,
                         answers: answers,
                         password: password,
                         currentPassword: currentPassword,
                         type: .updateInfo)
    }
    
    /// Update user preferences (must be logged in with access token).
    /// So that, the updated answers will effect the recommendation engine's work upon user's preferences.
    /// After updating user info, future trips of the user will be affected.
    ///
    /// This method is used in editing only user preferences, first name and last name of the user will not be affected.
    ///
    /// - Parameters:
    ///   - answers: An Integer array which refers to User preferences.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPUserInfoModel** object.
    public func updateUserAnswer(answers: [Int], completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(answers: answers, type: .updateAnswer)
    }
    
    /// A services which will be used in user info services, manages all task connecting to remote server.
    private func userInfoServices(firstName: String? = nil,
                                  lastName: String? = nil,
                                  dateOfBirth: String? = nil,
                                  answers: [Int]? = nil,
                                  password: String? = nil,
                                  currentPassword: String? = nil,
                                  type: TRPUserInfoServices.ServiceType) {
        var infoService: TRPUserInfoServices?
        
        if type == .getInfo {
            infoService = TRPUserInfoServices(type: .getInfo)
        } else if type == .updateAnswer {
            if let answers = answers {
                infoService = TRPUserInfoServices(answers: answers)
            }
        } else if type == .updateInfo {
            infoService = TRPUserInfoServices(firstName: firstName,
                                              lastName: lastName,
                                              dateOfBirth: dateOfBirth,
                                              password: password,
                                              currentPassword: currentPassword,
                                              answers: answers)
        }
        
        guard let services = infoService else {return}
        
        services.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPUserInfoJsonModel {
                TRPUserPersistent.saveUserEmail(serviceResult.data.email)
                self.postData(result: serviceResult.data, pagination: pagination)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        
        services.connection()
    }
    
}

//MARK: User Delete
extension TRPRestKit {
    public func deleteUser(completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteUserService()
    }
    
    private func deleteUserService() {
        let deleteService = TRPUserDeleteServices()
        deleteService.completion = { result, error, pagination in
//            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPParentJsonModel {
                TRPUserPersistent.remove()
                self.postData(result: serviceResult, pagination: pagination)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        deleteService.connection()
    }
}

//MARK: Reset Password
extension TRPRestKit {
    public func sendEmailForResetPassword(email: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        self.resetPasswordService(email: email)
    }
    public func resetPassword(password: String, hash: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        self.resetPasswordService(password: password, hash: hash)
    }
    
    private func resetPasswordService(email: String? = nil, password: String? = nil, hash: String? = nil) {
        var service: TRPResetPasswordServices?
        if let email = email {
            service = TRPResetPasswordServices(email: email)
        } else if let password = password, let hash = hash {
            service = TRPResetPasswordServices(password: password, hash: hash)
        }
        guard let service = service else { return }

        service.completion = { result, error, pagination in
            self.parseAndPost(TRPParentJsonModel.self, result, error, pagination)
        }
        service.connection()
    }
}

