//
//  TRPRestKit.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 22.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//
//
import Foundation
@objc public class TRPRestKit:NSObject {
    
    public typealias CompletionHandler = (_ result:Any?, _ error: NSError?)-> Void;
    public typealias CompletionHandlerWithPagination = (_ result:Any?, _ error: NSError?, _ pagination:Pagination?)-> Void;
    
    var completionHandler: CompletionHandler?;
    var completionHandlerWithPagination: CompletionHandlerWithPagination?;
    
    
    public override init() {}
    
    fileprivate func postData(result: Any?, pagination: Pagination? = Pagination.completed){
        if let comp = completionHandler {
            comp(result,nil);
        }else if let withPagination = completionHandlerWithPagination {
            withPagination(result,nil,pagination)
        }
    }
    
    fileprivate func postError(error: NSError?, pagination:Pagination? = Pagination.completed){
        if let comp = completionHandler {
            comp(nil,error);
        }else if let full = completionHandlerWithPagination {
            full(nil,error,pagination);
        }
    }
    
}

// MARK: - Cities Services
extension TRPRestKit {
    
    @objc public func cities(completion: @escaping CompletionHandler) {
        self.completionHandler = completion;
        citiesServices(id: nil);
    }
    
    public func cities(completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        citiesServices(id: nil);
    }
    
    public func city(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        citiesServices(id: withId);
    }
    
    public func city(link: String, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        citiesServices(id: nil,link: link);
    }
    
    private func citiesServices(id:Int?, link:String? = nil) -> Void {
        var t: TRPCities?;
        if id == nil {
            t = TRPCities();
        }else {
            t = TRPCities(cityId: id!);
        }
        
        t?.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPCityJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        if let link = link {
            t?.connection(link: link)
        }else {
            t?.connection();
        }
        
    }
    
}


// MARK: - Places Type Services
extension TRPRestKit {
    
    public func placeTypes(completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placeTypeServices(id: nil)
    }
    
    public func placeTypes(completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placeTypeServices(id: nil)
    }
    
    public func placeTypes(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placeTypeServices(id: withId);
    }
    
    private func placeTypeServices(id:Int?) -> Void {
        var t: TRPType?;
        if id == nil {
            t = TRPType();
        }else {
            t = TRPType(typeId: id!);
        }
        
        t?.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPPlaceTypeJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        t?.connection();
    }
}


// MARK: - Places Services
extension TRPRestKit {
    
    public func places(completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placesServices(placeIds: nil, cities: nil)
    }
    
    public func places(completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placesServices(placeIds: nil, cities: nil)
    }
    
    public func place(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placesServices(placeIds: [withId], cities: nil)
    }
    
    public func places(withIds:[Int], completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placesServices(placeIds: withIds, cities: nil)
    }
    
    public func places(withCityId:Int, limit:Int? = 100, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placesServices(placeIds: nil, cities: [withCityId],limit: limit)
    }
    
    public func places(withCityId:Int, limit:Int? = 100, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placesServices(placeIds: nil, cities: [withCityId],limit: limit)
    }
    
    public func places(link: String, limit:Int? = 100, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placesServices(placeIds: nil, cities: nil, limit: limit, link: link)
    }
    
    private func placesServices(placeIds:[Int]?,cities:[Int]?, limit:Int? = 25, link: String? = nil) -> Void {
        var t: TRPPlace?;
        
        if placeIds == nil && cities == nil {
            t = TRPPlace();
        }else if let places = placeIds {
            t = TRPPlace(ids: places);
        }else if let cities = cities {
            t = TRPPlace(cities: cities)
        }
        t?.limit = limit ?? 25
        t?.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPPlaceJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        if let link = link {
            t?.connection(link: link)
        }else {
            t?.connection();
        }
        
    }
    
}


// MARK: - Question Services
extension TRPRestKit {
    
    public func question(cityId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        questionServices(cityId: cityId);
    }
    
    public func question(cityId:Int, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        questionServices(cityId: cityId);
    }
    
    private func questionServices(cityId:Int) {
        let t = TRPQuestion(cityId: cityId);
        t.Completion = {(result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPQuestionJsonModel {
                self.postData(result: r);
            }
        }
        t.connection();
    }
    
}


// MARK: - Recommendation
extension TRPRestKit {
    
    public func recommendation(settings:TRPRecommendationSettings, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        recoomendationServices(settings: settings)
    }
    
    public func recommendation(settings:TRPRecommendationSettings, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        recoomendationServices(settings: settings)
    }
    
    private func recoomendationServices(settings:TRPRecommendationSettings) {
        let t = TRPRecommendation(settings: settings);
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPRecommendationJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        t.connection();
    }
    
}


// MARK: - USER
extension TRPRestKit {
    
    public func userLogin(email:String, password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userOAuthServices(email: email, password: password)
    }
    
    public func createUser(firstName:String, lastName:String, email:String, password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userServices(firstName: firstName, lastName: lastName, email: email, password: password, status: TRPUser.UserStatus.create)
    }
    
    public func updateUser(firstName:String, lastName:String, email:String, password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userServices(firstName: firstName, lastName: lastName, email: email, password: password, status: TRPUser.UserStatus.update)
    }
    
    public func getUserInfo(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userMeServices()
    }
    
    
    private func userOAuthServices(email:String, password:String) {
        let t = TRPOAuth(email: email, password: password)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            //TODO: - SAVE USER ID
            if let r = result as? TRPOAuthJsonModel {
                TRPUserPersistent.saveHash(r.data.accessToken)
                self.postData(result: r, pagination: pagination)
            }
        }
        t.connection();
    }

    private func userServices(firstName:String, lastName:String, email:String, password:String, id:Int? = nil, status: TRPUser.UserStatus) {
        var services: TRPUser?
        
        if status == .create {
            services = TRPUser(firstName: firstName, lastName: lastName, email: email, password: password)
        }else if status == .update{
            services = TRPUser(id: 1, firstName: firstName, lastName: lastName, password: password)
        }
        
        services!.Completion = {(result, error,_) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPRoutesJsonModel {
                self.postData(result: r);
            }
        }
        services!.connection();
    }

    private func userMeServices() {
        let t = TRPUserMe()
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPUserMeJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        t.connection();
    }
}


// MARK: - Routes Services ---- silinecek
extension TRPRestKit {
    
    
 
}

// MARK: - Routes Result Services
extension TRPRestKit {
    
    public func routesResult(hash: String, completion: @escaping CompletionHandler){
        completionHandler = completion;
        routesResultServices(hash: hash)
    }
    
    public func routesResult(hash: String, completion: @escaping CompletionHandlerWithPagination){
        completionHandlerWithPagination = completion;
        routesResultServices(hash: hash)
    }
    
    private func routesResultServices(hash:String) {
        DispatchQueue.global().async {
            self.routesResultServicesLooper(hash: hash);
        }
    }
    
    
    private func routesResultServicesLooper(hash:String){
        let t = TRPRoutesResult(hash: hash);
        t.Completion = {(result, error,pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            guard let result = result as? TRPRoutesResultJsonModel else {return}
            
            if let waitMain = result.waitResult, let waitResult = waitMain.wait {
                if waitResult == true {
                    print("**** Wait until server crete a route");
                    sleep(1)
                    self.routesResultServicesLooper(hash: hash)
                    return
                }
            }
            self.postData(result: result, pagination: pagination)
        }
        t.connection();
    }
}


// MARK: - Google Route Services
extension TRPRestKit {
    
    public func gRoutesResult(hash: String, completion: @escaping CompletionHandler){
        completionHandler = completion;
        gRoutesResultServices(hash: hash)
    }
    
    public func gRoutesResult(hash: String, completion: @escaping CompletionHandlerWithPagination){
        completionHandlerWithPagination = completion;
        gRoutesResultServices(hash: hash)
    }
    
    private func gRoutesResultServices(hash:String) {
        print("Algoritma başladı");
        DispatchQueue.global().async {
            self.gRoutesResultServicesLooper(hash: hash);
        }
    }
    
    private func gRoutesResultServicesLooper(hash:String){
        let t = TRPGrouteResult(hash: hash);
        t.Completion = {(result, error,pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            guard let result = result as? TRPGRoutesResultJsonModel else {return}
            
            if let waitMain = result.waitResult, let waitResult = waitMain.wait {
                if waitResult == true {
                    print("**** Wait until server crete a route");
                    sleep(1)
                    self.gRoutesResultServicesLooper(hash: hash)
                    return
                }
            }
            self.postData(result: result, pagination: pagination)
        }
        t.connection();
    }
}

// MARK: - NearBy Services
extension TRPRestKit {
    
    public func nearBy(withProgramStepId stepId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        nearByServices(stepId: stepId, hash: nil)
    }
    
    public func nearByAll(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        nearByServices(stepId: nil, hash: hash)
    }
    
    
    private func nearByServices(stepId: Int?, hash: String?) {
        var t:TRPNearBy?
        
        if let stepId = stepId {
            t = TRPNearBy(programStepId: stepId)
        }else if let hash = hash {
            t = TRPNearBy(hash: hash)
        }
        
        t?.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPNearByJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        t?.connection()
    }
    
}


// MARK: - Tags Services
extension TRPRestKit {
    
    public func tagsServices(completion: @escaping CompletionHandler){
        completionHandler = completion;
        tagsServicesServices()
    }
    
    
    /// Tag listesinin çekilir
    /// - note: donen obje TRPTagsJsonModel
    /// - SeeAlso: 'tagsServices(completion: @escaping CompletionHandler)'
    /// - Parameter completion: pagination, error, any
    public func tagsServices(completion: @escaping CompletionHandlerWithPagination){
        completionHandlerWithPagination = completion;
        tagsServicesServices()
    }
    
    public func tagsServices(limit:Int? = 2000,completion: @escaping CompletionHandlerWithPagination){
        completionHandlerWithPagination = completion;
        tagsServicesServices(limit: limit)
    }
    
    public func tagsServices(link: String, limit:Int? = 2000, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        tagsServicesServices(limit: limit, link: link)
    }
    
    private func tagsServicesServices(limit:Int? = 2000, link:String? = nil) {
        
        let t = TRPTags()
        if let limit = limit {
            t.limit = limit
        }
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPTagsJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        
        if let directLink = link {
            t.connection(link: directLink)
        }else {
            t.connection();
        }
    }
    
}


extension TRPRestKit {
    
    public func checkUpdate(cityId:Int, cityUpdate:Int, completion: @escaping CompletionHandlerWithPagination){
        completionHandlerWithPagination = completion;
        checkUpdateServices(cityId: cityId, cityUpdate: cityUpdate)
    }
    
    public func checkUpdate(cityId:Int, cityUpdate:Int, tagUpdate:Int? = nil, placeUpdate:Int? = nil, completion: @escaping CompletionHandlerWithPagination){
        completionHandlerWithPagination = completion;
        checkUpdateServices(cityId: cityId, cityUpdate: cityUpdate, tagUpdate: tagUpdate,placeUpdate: placeUpdate);
    }
    
    private func checkUpdateServices(cityId:Int, cityUpdate:Int, tagUpdate:Int? = nil, placeUpdate:Int? = nil) {
        let t = TRPCheckDataUpdates(cityId: cityId,cityUpdate: cityUpdate);
        t.tagUpdate = tagUpdate
        t.placeUpdate = placeUpdate
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPCheckUpdateJsonModel {
                self.postData(result: r, pagination: pagination)
            }
        }
        t.connection()
    }
}


extension TRPRestKit {
    
    public func getMyProgram(completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        myProgramServices()
    }
    
    private func myProgramServices() {
        let t = TRPMyProgram()
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let r = result as? TRPMyProgramsJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
    public func createProgram(settings:TRPProgramSettings, completion: @escaping CompletionHandler){
        completionHandler = completion;
        createProgramServices(settings: settings)
    }
    
    private func createProgramServices(settings:TRPProgramSettings) {
        let t = TRPProgram(setting: settings)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPProgramJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
    public func getProgram(withHash:String, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        getProgramServices(hash: withHash)
    }
    
    private func getProgramServices(hash: String) {
        let t = TRPGetProgram(hash: hash)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPProgramJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
    public func deleteProgram(hash:String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteProgramServices(hash: hash)
    }
    
    private func deleteProgramServices(hash:String) {
        
        let t = TRPDeleteProgram(hash: hash)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPParentJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
}

// MARK: - Program Day
extension TRPRestKit {
    
    public func addNewProgramDayIn(hash: String, position: TRPProgramDayPosition, completion: @escaping CompletionHandler) {
        completionHandler = completion
        programDayServices(hash: hash, position: position)
    }
    
    public func programDayServices(hash: String, position: TRPProgramDayPosition){
        let t = TRPProgramDay(hash: hash, position: position)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPProgramDayJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
    public func getProgramDay(dayId:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getProgramDayServices(dayId: dayId)
    }
    
    private func getProgramDayServices(dayId:Int) {
        let t = TRPGetProgramDay(id: dayId)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPProgramDayJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
    public func deleteProgramDay(dayId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getProgramDayServices(dayId: dayId)
    }
    
    public func deleteProgramDayServices(dayId: Int) {
        
        let t = TRPDeleteProgramDay(id: dayId)
        t.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPParentJsonModel {
                self.postData(result: r)
            }
        }
        t.connection()
    }
    
}


// MARK: - Preferences
extension TRPRestKit {
    
    public func getPreferences(completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(type: TRPPreferences.PreferenceStatus.get)
    }
    
    public func addPreferences(key: String, value: String, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(key: key, value: value, type: TRPPreferences.PreferenceStatus.add)
    }
    
    public func updatePreferencees(id:Int, key:String, value: String, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(id: id, key: key, value: value, type: TRPPreferences.PreferenceStatus.update)
    }
    
    public func deletePreferences(id:Int, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(id: id, type: TRPPreferences.PreferenceStatus.delete)
    }
    
    private func preferencesServices(id:Int? = nil,
                                     key:String? = nil,
                                     value: String? = nil,
                                     type: TRPPreferences.PreferenceStatus) {
        var t: TRPPreferences?
        
        switch type {
        case .get:
            t = TRPPreferences()
            break;
        case .add:
            t = TRPPreferences(key: key ?? "", value: value ?? "", type: type)
            break;
        case .update:
            t = TRPPreferences(id: id ?? 0 , key: key ?? "", value: value ?? "")
            break;
        case .delete:
            t = TRPPreferences(id: id ?? 0)
            break;
        }
        
        t?.Completion = {(result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPPreferenceJsonModel {
                self.postData(result: r)
            }
        }
        t?.connection()
        
    }
}




