
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
    /// The aaacompletion handler to call when the load request is complete.
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
    deinit {
        print("RESTKİT DEİNİT")
    }
 }
 
 // MARK: - Cities Services
 extension TRPRestKit {
    
    /// Seyahat planı oluşturmak için gerekli olan şehirlerin tam listesini getirir.
    /// Getirilen verilerde şehre ait id, konum, görsel vs... veriler bulunur.
    /// Veri çekmek işlemi tamamlandığında completionHandler tetiklenir, bu sayede veri çekme işlemini bitmesi beklenmeden işlemler devam eder.
    /// CompletionHandler Any, NSError ve Pagination objelerini döndürür.
    ///
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    ///                                 - Any tipinde donen değer casting işlemi ile **[TRPCityInfoModel]** dizisine donusturulmelidir.
    ///                                 - Error değeri, HTTP sorgusunda veya JsonParser işleminde hata oluşursa dondurulur. Herhangi bir hata yoksa 'nil' doner.
    ///                                 - Pagination nesnesi, veri birden fazla sorguda dondurulecekse oluşturulur. Pagination enum tipindedir. Pagination continues ise verinin devamı vardır. Continues içinde gelen değer yeni sayfanın linkidir. Pagination completed ise tüm veriler çekilmiştir.
    ///
    public func cities(completionHandler: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completionHandler;
        citiesServices(id: nil);
    }
    
    public func city(with id: Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        citiesServices(id: id);
    }
    
    public func city(with location: TRPLocation, completionHandler: @escaping CompletionHandler){
        self.completionHandler = completionHandler;
        citiesServices(location: location)
    }
    
    public func city(link: String, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        citiesServices(id: nil,link: link);
    }
    
    private func citiesServices(id:Int? = nil,
                                link:String? = nil,
                                location: TRPLocation? = nil) -> Void {
        var t: TRPCities?;
        if id == nil && location == nil && link == nil{
            t = TRPCities();
        }else if let id = id{
            t = TRPCities(cityId: id);
        }else if let location = location {
            t = TRPCities(location: location)
        }
        guard let service = t else {return}
        
        service.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPCityJsonModel{
                if let cities = r.data {
                    if id != nil || location != nil {
                        if let city = cities.first {
                             self.postData(result: city, pagination: pagination)
                            return
                        }
                    }else {
                         self.postData(result: cities, pagination: pagination)
                        return
                    }
                }
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        
        if let link = link {
            service.connection(link: link)
        }else {
            service.connection();
        }
    }
    
 }
 
 
 // MARK: - Places Type Services
 extension TRPRestKit {
    
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
        t?.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            
            if let r = result as? TRPPlaceTypeJsonModel{
                if let types = r.data {
                    if id == nil{
                         self.postData(result: types, pagination: pagination)
                        return
                    }else {
                        if let type = types.first {
                             self.postData(result: type, pagination: pagination)
                            return
                        }
                    }
                }
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        t?.connection();
    }
 }
 
 
 // MARK: - Places Services
 extension TRPRestKit {
    
    public func place(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        placesServices(placeIds: [withId], cities: nil)
    }
    
    public func places(withIds ids:[Int], cityId: Int, autoPagination:Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placesServices(placeIds: ids, cities: [cityId], autoPagination: autoPagination)
    }
    
    public func places(withCityId cityId:Int, limit:Int? = 100, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placesServices(placeIds: nil, cities: [cityId],limit: limit)
    }
    
    public func places(link: String, limit:Int? = 100, autoPagination:Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        placesServices(placeIds: nil, cities: nil, limit: limit, link: link, autoPagination:autoPagination)
    }
    
    public func places(withLocation location: TRPLocation,
                       distance: Double? = nil,
                       typeId: Int? = nil,
                       autoPagination: Bool? = false,
                       limit: Int? = 25,
                       completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        placesServices(limit: limit, location: location, distance: distance, typeId: typeId, autoPagination: autoPagination ?? false)
    }
    
    
    private func placesServices(placeIds: [Int]? = nil,
                                cities: [Int]? = nil,
                                limit: Int? = 25,
                                location: TRPLocation? = nil,
                                distance: Double? = nil,
                                typeId: Int? = nil,
                                link: String? = nil,
                                autoPagination:Bool = true) -> Void {
        var t: TRPPlace?;
        
        if let places = placeIds, let cities = cities, let city = cities.first{
            t = TRPPlace(ids: places, cityId:city);
        }else if let location = location{
            t = TRPPlace(location: location,distance: distance)
        }else if let cities = cities {
            t = TRPPlace(cities: cities)
        }else if link != nil {
            t = TRPPlace()
        }
        
        guard let services = t else {return}
        
        services.isAutoPagination = autoPagination
        services.limit = limit ?? 25
        services.Completion = {    (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPPlaceJsonModel{
                if let places = r.data {
                     self.postData(result: places, pagination: pagination)
                    return
                }
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        if let link = link {
            services.connection(link: link)
        }else {
            services.connection();
        }
    }
    
 }
 
 
 // MARK: - Question Services
 extension TRPRestKit {
    
    public func tripQuestions(withQuestionId questionId: Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        questionServices(questionId: questionId)
    }
    
    public func tripQuestions(withCityId cityId: Int, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        questionServices(cityId: cityId)
    }
    
    private func questionServices(cityId:Int? = nil,
                                  questionId: Int? = nil) {
        
        var t: TRPTripQuestion?
        
        if let cityId = cityId {
            t = TRPTripQuestion(cityId: cityId)
        }else if let questionId = questionId  {
            t = TRPTripQuestion(questionId: questionId)
        }
        
        guard let services = t else {return}
        services.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            
            if let r = result as? TRPTripQuestionJsonModel{
                if let questions = r.data {
                    if questionId != nil {
                        if let quesion = questions.first {
                             self.postData(result: quesion)
                        }
                    }else {
                         self.postData(result: questions, pagination: pagination)
                        return
                    }
                    
                }
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services.connection();
    }
    
 }
 
 
 // MARK: - Recommendation
 extension TRPRestKit {
    
    // TODO: PAGİNATİON VE AUTOPAGİN KALKACAK
    /// Fetch recommendation with settings
    ///
    /// - Parameters:
    ///   - settings: Recommendation setting
    ///   - completion: Callback with Pagination
    /// - Important: CallBack class is [TRPRecommendationInfoJsonModel]
    public func recommendation(settings:TRPRecommendationSettings, autoPagination: Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        recoomendationServices(settings: settings, autoPagination: autoPagination)
    }
    
    private func recoomendationServices(settings:TRPRecommendationSettings, autoPagination: Bool) {
        let t = TRPRecommendation(settings: settings);
        t.isAutoPagination = autoPagination
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            
            if let r = result as? TRPRecommendationJsonModel, let recommendationPlaces = r.data {
                 self.postData(result: recommendationPlaces, pagination: pagination)
            }else {
                 self.postData(result: [], pagination: pagination)
            }
        }
        t.connection();
    }
    
 }
 
 
 // MARK: - USER LOGİN
 extension TRPRestKit {
    /// seeAlso: TRPOAuthJsonModel
    public func login(email:String, password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(email: email, password: password)
    }
    
    private func loginServices(email:String, password:String) {
        let t = TRPLogin(email: email, password: password)
        t.Completion = {    (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            //TODO: - SAVE USER ID
            if let r = result as? TRPOAuthJsonModel{
                TRPUserPersistent.saveHash(r.data.accessToken)
                 self.postData(result: r.data, pagination: pagination)
            }else  {
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        t.connection();
    }
    
 }
 
 
 
 // MARK: - USER
 extension TRPRestKit {
    // TRPUserLoginInfoModel
    
    
    /// Yeni Kullanıcı oluşturmak için kullanılır.
    ///
    /// - Parameters:
    ///   - firstName: kullanıcı adı
    ///   - lastName: kullanıcı soyadı
    ///   - email: kullanıcının mail adresi
    ///   - password: şifresi
    ///   - completion: any obje **TRPUserInfoModel**
    public func register(firstName:String, lastName:String, email:String, password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(firstName: firstName, lastName: lastName, email: email, password: password, status: TRPUserRegister.UserStatus.create)
        
    }
    
    public func userInfo(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userInfoServices()
    }
    
    private func userInfoServices() {
        let t = TRPUserMe()
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPUserMeJsonModel {
                 self.postData(result: r.data, pagination: pagination)
            }
        }
        t.connection();
    }
    
    private func userRegisterServices(firstName:String,
                                      lastName:String,
                                      email:String,
                                      password:String,
                                      id:Int? = nil,
                                      status: TRPUserRegister.UserStatus) {
        
        var services: TRPUserRegister?
        if status == .create {
            services = TRPUserRegister(firstName: firstName, lastName: lastName, email: email, password: password)
        }else if status == .update{
            services = TRPUserRegister(id: 1, firstName: firstName, lastName: lastName, password: password)
        }
        
        services!.Completion = {   (result, error,_) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPUserMeJsonModel {
                 self.postData(result: r.data);
            }else {
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services!.connection();
    }
 }
 
 
 // MARK: - User Trips
 extension TRPRestKit {
    
    public func userTrips(completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        myProgramServices()
    }
    
    private func myProgramServices() {
        let t = TRPUserTrips()
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            
            if let r = result as? TRPUserTripsJsonModel {
                 self.postData(result: r.data)
            }
        }
        t.connection()
    }
    
 }
 
 // MARK: - User Preferences
 extension TRPRestKit {
    
    public func userPreferences(completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(type: TRPUseerPreferences.PreferenceStatus.get)
    }
    
    public func addUserPreferences(key: String, value: String, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(key: key, value: value, type: TRPUseerPreferences.PreferenceStatus.add)
    }
    
    public func updateUserPreferencees(id:Int, key:String, value: String, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(id: id, key: key, value: value, type: TRPUseerPreferences.PreferenceStatus.update)
    }
    
    public func deleteUserPreferences(id:Int, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        preferencesServices(id: id, type: TRPUseerPreferences.PreferenceStatus.delete)
    }
    
    private func preferencesServices(id:Int? = nil,
                                     key:String? = nil,
                                     value: String? = nil,
                                     type: TRPUseerPreferences.PreferenceStatus) {
        var t: TRPUseerPreferences?
        
        switch type {
        case .get:
            t = TRPUseerPreferences()
            break;
        case .add:
            t = TRPUseerPreferences(key: key ?? "", value: value ?? "", type: type)
            break;
        case .update:
            t = TRPUseerPreferences(id: id ?? 0 , key: key ?? "", value: value ?? "")
            break;
        case .delete:
            t = TRPUseerPreferences(id: id ?? 0)
            break;
        }
        
        t?.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPPreferenceJsonModel, let pref = r.data {
                 self.postData(result: pref)
            }
        }
        t?.connection()
        
    }
 }
 
 
 // MARK: - Trip
 extension TRPRestKit {
    
    public func createTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler){
        completionHandler = completion;
        createTripServices(settings: settings)
    }
    
    private func createTripServices(settings: TRPTripSettings) {
        let t = TRPProgram(setting: settings)
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPTripJsonModel {
                 self.postData(result: r)
            }
        }
        t.connection()
    }
    
    public func getTrip(withHash hash:String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getTripServices(hash: hash)
    }
    
    private func getTripServices(hash: String) {
        let t = TRPGetProgram(hash: hash)
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPTripJsonModel, let info = r.data {
                 self.postData(result: info)
            }
        }
        t.connection()
    }
    
    public func deleteTrip(hash:String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteTripServices(hash: hash)
    }
    
    private func deleteTripServices(hash:String) {
        
        let t = TRPDeleteProgram(hash: hash)
        t.Completion = {   (result, error, pagination) in
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
 
 // MARK: - Day Plan
 extension TRPRestKit {
    
    public func dayPlan(id:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        dayPlanServices(id: id)
    }
    
    private func dayPlanServices(id:Int) {
        let t = TRPDayPlan(id: id)
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPDayPlanJsonModel {
                 self.postData(result: r)
            }
        }
        t.connection()
    }
    
 }
 
 // MARK: - PlanPoints
 extension TRPRestKit {
    
    public func addPlanPoints(hash: String, dayId: Int, placeId: Int, order: Int? = nil, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(hash: hash, dayId: dayId, placeId: placeId, order: order, type: TRPPlanPoints.Status.add)
    }
    
    //id = programStepId
    public func updatePlanPoints(id: Int, placeId: Int? = nil, order: Int? = nil, completion: @escaping CompletionHandler ) {
        completionHandler = completion;
        planPointsServices(id: id, placeId: placeId, order: order, type: .update)
    }
    
    public func deletePlanPoints(id:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(id: id, type: .delete)
    }
    
    private func planPointsServices(hash: String? = nil,
                                    id: Int? = nil,
                                    dayId: Int? = nil,
                                    placeId: Int? = nil,
                                    order: Int? = nil, type:TRPPlanPoints.Status) {
        var t: TRPPlanPoints?
        
        if type == TRPPlanPoints.Status.delete, let id = id {
            t = TRPPlanPoints(id: id, type: type)
        }else if type == TRPPlanPoints.Status.add, let hash = hash, let dayId = dayId, let placeId = placeId {
            t = TRPPlanPoints(hash: hash, dayId: dayId, placeId: placeId, order: order)
        }else if type == TRPPlanPoints.Status.update, let id = id {
            t = TRPPlanPoints(id: id, dayId: dayId, placeId: placeId, order: order)
        }
        
        guard let service = t else {
            self.postError(error: TRPErrors.objectIsNil(name: "TRPPlanPoints") as NSError)
            return
        }
        
        service.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if type == .delete {
                if let r = result as? TRPParentJsonModel {
                     self.postData(result: r, pagination: pagination)
                    return
                }
            }else {
                if let r = result as? TRPProgramStepJsonModel, let data = r.data {
                     self.postData(result: data, pagination: pagination)
                    return
                }
            }
             self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        service.connection()
    }
    
    
 }
 
 // MARK: - NearBy Services
 extension TRPRestKit {
    
    public func planPointAlternatives(withPlanPointId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointAlternative(planPointId: id, hash: nil)
    }
    
    public func planPointAlternatives(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointAlternative(planPointId: nil, hash: hash)
    }
    
    
    private func planPointAlternative(planPointId: Int?, hash: String?) {
        var t:TRPPlanPointAlternatives?
        
        if let planPointId = planPointId {
            t = TRPPlanPointAlternatives(planPointId: planPointId)
        }else if let hash = hash {
            t = TRPPlanPointAlternatives(hash: hash)
        }
        
        t?.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPPlanPointAlternativeJsonModel, let data = r.data {
                 self.postData(result: data, pagination: pagination)
                return
            }
              self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        t?.connection()
    }
    
 }
 
 
 
 
 
 
 
 //************************************************************************************************************************************************************
 
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
        t.Completion = {   (result, error,pagination) in
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
        t.Completion = {   (result, error,pagination) in
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
        t.Completion = { (result, error, pagination) in
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
        t.Completion = { (result, error, pagination) in
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
 
