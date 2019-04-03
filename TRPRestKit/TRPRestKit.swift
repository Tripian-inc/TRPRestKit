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

 
@objc public class TRPRestKit:NSObject {
    public func pListTest() {
        let userName = Environment().configuration(PlistKey.ConfigName)
        print("Plist User Name In Config \(userName)")
    }
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
                                location: TRPLocation? = nil, limit: Int? = 25) -> Void {
        var t: TRPCities?;
        if id == nil && location == nil && link == nil{
            t = TRPCities();
        }else if let id = id{
            t = TRPCities(cityId: id);
        }else if let location = location {
            t = TRPCities(location: location)
        }
        
        guard let service = t else {return}
        service.limit = limit ?? 50
        
        service.Completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPCityJsonModel{
                if let cities = r.data {
                    if id != nil || location != nil {
                        if let city = cities.first {
                            sleep(4)
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
    
    public func poiCategories(completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiCategoriesServices(id: nil)
    }
    
    public func poiCategories(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        poiCategoriesServices(id: withId);
    }
    
    private func poiCategoriesServices(id:Int?) -> Void {
        var t: PoiCategories?;
        if id == nil {
            t = PoiCategories();
        }else {
            t = PoiCategories(typeId: id!);
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
    
    public func poi(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        poiServices(placeIds: [withId], cities: nil)
    }
    
    public func poi(withIds ids:[Int], cityId: Int, autoPagination:Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiServices(placeIds: ids, cities: [cityId], autoPagination: autoPagination)
    }
    
    public func poi(withCityId cityId:Int, limit:Int? = 100, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiServices(placeIds: nil, cities: [cityId],limit: limit)
    }
    
    public func poi(link: String, limit:Int? = 100, autoPagination:Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiServices(placeIds: nil, cities: nil, limit: limit, link: link, autoPagination:autoPagination)
    }
    
    public func poi(withLocation location: TRPLocation,
                       distance: Double? = nil,
                       cityId: Int? = nil,
                       typeId: Int? = nil,
                       types: [Int]? = nil,
                       autoPagination: Bool? = false,
                       limit: Int? = 25,
                       completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        poiServices(limit: limit,
                    location: location,
                    distance: distance,
                    typeId: typeId,
                    typeIds: types,
                    cityId: cityId,
                    autoPagination: autoPagination ?? false)
    }
    
    public func poi(search: String,
                    cityId: Int? = nil,
                    location userLoc: TRPLocation? = nil,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        poiServices(location: userLoc,
                    searchText: search,
                    cityId: cityId,
                    autoPagination:false)
    }
    
    private func poiServices(placeIds: [Int]? = nil,
                                cities: [Int]? = nil,
                                limit: Int? = 25,
                                location: TRPLocation? = nil,
                                distance: Double? = nil,
                                typeId: Int? = nil,
                                typeIds: [Int]? = nil,
                                link: String? = nil,
                                searchText: String? = nil,
                                cityId: Int? = nil,
                                autoPagination:Bool = true) -> Void {
        var t: TRPPlace?;
        if let places = placeIds, let cities = cities, let city = cities.first{
            t = TRPPlace(ids: places, cityId:city);
        }else if let search = searchText {
            t = TRPPlace(location: location,
                         searchText: search,
                         cityId: cityId)
        }else if let location = location{
            t = TRPPlace(location: location,distance: distance)
            if let id = typeId {
                t?.typeId = id
            }
            if let ids = typeIds {
                t?.typeIds = ids
            }
            t?.cityId = cityId
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
            if let r = result as? TRPPoiJsonModel{
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
    
    public func tripQuestions(withCityId cityId: Int,
                              type: TPRTripQuestionType? = TPRTripQuestionType.trip,
                              completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        questionServices(cityId: cityId, type:type)
    }
    
    private func questionServices(cityId:Int? = nil,
                                  questionId: Int? = nil,
                                  type: TPRTripQuestionType? = nil) {
        
        var t: TRPTripQuestion?
        
        if let cityId = cityId {
            t = TRPTripQuestion(cityId: cityId)
        }else if let questionId = questionId  {
            t = TRPTripQuestion(questionId: questionId)
        }
        
        guard let services = t else {return}
        services.tripType = type ?? .trip
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
    
    /// seeAlso: TRPLoginInfoModel
    public func login(userName name:String, password: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(userName: name, password: password)
    }
    
    private func loginServices(userName name: String, password: String) {
        let t = TRPLogin(userName: name, password: password)
        t.Completion = {    (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            //TODO: - SAVE USER ID
            if let r = result as? TRPLoginJsonModel{
                TRPUserPersistent.saveHash(r.data.accessToken)
                 self.postData(result: r.data, pagination: pagination)
            }else  {
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        t.connection();
    }
    
    public func logout() {
        TRPUserPersistent.remove()
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
    public func register(password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(password: password)
    }
    
    public func userInfo(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userInfoServices(type: .getInfo)
    }
    
    private func userRegisterServices(password: String) {
        let services = TRPUserRegister(password: password)
        services.Completion = {   (result, error,_) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPUserInfoJsonModel {
                 self.postData(result: r.data);
            }else {
                 self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services.connection();
    }
    
    
 }
 
// MARK: Update User Info
extension TRPRestKit {
    
    public func updateUserAnswer(answers: [Int], completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(answers: answers, type: .updateAnswer)
    }
    
    public func updateUserInfo(firstName: String? = nil,
                               lastName: String? = nil,
                               password: String? = nil,
                               answers: [Int]? = nil,
                               completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(firstName: firstName, lastName: lastName, password: password, answers: answers, type: .updateInfo)
    }
    
    
    private func userInfoServices(firstName: String? = nil,
                                        lastName: String? = nil,
                                        password: String? = nil,
                                        answers: [Int]? = nil,
                                        type: TRPUserInfoServices.ServiceType) {
        var t: TRPUserInfoServices?
        
        if type == .getInfo {
            t = TRPUserInfoServices(type: .getInfo)
        }else if type == .updateAnswer {
            if let answers = answers {
                t = TRPUserInfoServices(answers: answers)
            }
        }else if type == .updateInfo {
            t = TRPUserInfoServices(firstName: firstName, lastName: lastName, password: password, answers: answers)
        }
        
        guard let services = t else {return}
        
        services.Completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPUserInfoJsonModel {
                self.postData(result: r.data, pagination: pagination)
            }
        }
        services.connection();
    }
}

extension TRPRestKit {

    public func addUserFavorite(cityId: Int, poiId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, poiId: poiId, mode: .add)
    }
    
    public func getUserFavorite(cityId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, mode: .get)
    }
    
    public func deleteUserFavorite(cityId: Int, poiId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, poiId: poiId, mode: .delete)
    }
    
    private func userFavoriteServices(cityId: Int, poiId: Int? = nil, mode: TRPUserFavorite.Mode) {
        
        var t: TRPUserFavorite?
        if mode == .add || mode == .delete{
            if let poi = poiId {
                t = TRPUserFavorite(cityId: cityId, poiId: poi, type: mode)
            }
        }else if mode == .get {
            t = TRPUserFavorite(cityId: cityId)
        }
        
        guard let services = t else {return}
        services.Completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if mode == .delete {
                if let r = result as? TRPParentJsonModel {
                    self.postData(result: r)
                    return
                }
            }else {
                if let r = result as? TRPFavoritesJsonModel {
                    if mode == .add {
                        if let first = r.data?.first {
                            self.postData(result: first)
                            return
                        }
                    }else {
                        self.postData(result: r.data, pagination: pagination)
                        return
                    }
                }
            }
            
            self.postError(error: TRPErrors.wrongData as NSError)
        }
        services.connection();
    }
}

  
  
  
  
  
  
  
 // MARK: - User Trips
 extension TRPRestKit {
    
    public func userTrips(limit:Int? = 100, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTripsServices(limit: 100)
    }
    
    private func userTripsServices(limit:Int) {
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
            if let data = result as? TRPTripJsonModel, let r = data.data {
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
        t.Completion = {  (result, error, pagination) in
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
        t.Completion = { (result, error, pagination) in
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
 
 // MARK: - Daily Plan
 extension TRPRestKit {
    
    public func dailyPlan(id:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        dailyPlanServices(id: id)
    }
    
    private func dailyPlanServices(id:Int) {
        let t = TRPDailyPlanServices(id: id)
        t.Completion = {   (result, error, pagination) in
            if let error = error {
                 self.postError(error: error)
                return
            }
            if let r = result as? TRPDayPlanJsonModel {
                 self.postData(result: r.data)
            }
        }
        t.connection()
    }
    
 }
 
 // MARK: - PlanPoints
 extension TRPRestKit {
    
    public func addPlanPoints(hash: String, dailyPlanId: Int, poiId: Int, order: Int? = nil, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(hash: hash, dailyPlanId: dailyPlanId, placeId: poiId, order: order, type: TRPPlanPoints.Status.add)
    }
    
    //id = programStepId
    public func replacePlanPoiFrom(dailyPlanPoiId: Int, poiId: Int? = nil, order: Int? = nil, completion: @escaping CompletionHandler ) {
        completionHandler = completion;
        planPointsServices(id: dailyPlanPoiId, placeId: poiId, order: order, type: .update)
    }
    
    public func reOrderPlanPoiFrom(dailyPlanPoiId: Int, poiId: Int, order: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(id: dailyPlanPoiId, placeId: poiId, order: order, type: .update)
    }
    
    public func deleteDailyPlanPoi(planPoiId id:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(id: id, type: .delete)
    }
    
    private func planPointsServices(hash: String? = nil,
                                    id: Int? = nil,
                                    dailyPlanId: Int? = nil,
                                    placeId: Int? = nil,
                                    order: Int? = nil, type:TRPPlanPoints.Status) {
        var t: TRPPlanPoints?
        
        if type == TRPPlanPoints.Status.delete, let id = id {
            t = TRPPlanPoints(id: id, type: type)
        }else if type == TRPPlanPoints.Status.add, let hash = hash, let dailyPlanId = dailyPlanId, let placeId = placeId {
            t = TRPPlanPoints(hash: hash, dailyPlanId: dailyPlanId, placeId: placeId, order: order)
        }else if type == TRPPlanPoints.Status.update, let id = id {
            t = TRPPlanPoints(id: id, placeId: placeId, order: order)
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
            }else if type == .add{
                if let r = result as? TRPPoiAddRouteJsonModel{
                    self.postData(result: r.data, pagination: pagination)
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
    
    public func planPoiAlternatives(withPlanPointId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointAlternative(planPointId: id)
    }
    
    public func planPoiAlternatives(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointAlternative(hash: hash)
    }
    
    public func planPoiAlternatives(withDailyPlanId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointAlternative(dailyPlanId: id)
    }
    
    
    private func planPointAlternative(planPointId: Int? = nil, hash: String? = nil, dailyPlanId: Int? = nil) {
        var t:TRPPlanPointAlternatives?
        
        if let planPointId = planPointId {
            t = TRPPlanPointAlternatives(planPointId: planPointId)
        }else if let hash = hash {
            t = TRPPlanPointAlternatives(hash: hash)
        }else if let dailyPlanId = dailyPlanId {
            t =  TRPPlanPointAlternatives(dailyPlanId: dailyPlanId)
        }
        
        guard let service = t else {return}
        service.Completion = {   (result, error, pagination) in
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
        service.connection()
    }
    
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

extension TRPRestKit {
    
    public func googleAutoComplete(key:String,
                                   text: String,
                                   centerForBoundary center: TRPLocation? = nil,
                                   radiusForBoundary radius: Double? = nil,
                                   completion: @escaping CompletionHandler){
        self.completionHandler = completion
        googlePlaceAutoCompleteService(key: key,
                                       text: text,
                                       centerForBoundary: center,
                                       radiusForBoundary: radius)
    }
    
    private func googlePlaceAutoCompleteService(key: String,
                                                text: String,
                                                centerForBoundary center: TRPLocation? = nil,
                                                radiusForBoundary radius: Double? = nil) {
        let t = TRPGoogleAutoComplete(key: key, text: text)
        t.centerLocationForBoundary = center
        t.radiusForBoundary = radius
        t.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let data = data as? [TRPGooglePlace] {
                self.postData(result: data)
            }else {
                print("hataaa")
            }
        }
    }

}

extension TRPRestKit {
    
    public func googlePlace(key:String, id: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googlePlaceServices(key:key, placeId: id)
    }
    
    private func googlePlaceServices(key:String, placeId: String) {
        let t = TRPGooglePlaceService(key: key, placeId: placeId)
        t.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let result = data as? TRPGooglePlaceLocation {
                self.postData(result: result)
            }
        }
    }
    
}

// MARK: - Problem Categories
extension TRPRestKit {
    
    public func problemCategories(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        problemCategoriesService()
    }
    
    //Return [TRPProblemCategoriesInfoModel]
    private func problemCategoriesService() {
        let t = TRPProblemCategories()
        t.Completion = { (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPProblemCategoriesJsonModel {
                self.postData(result: r.datas)
            }
        }
        t.connection()
    }
    
}

//Send a problem
extension TRPRestKit {
    
    public func reportaProblem(category id: Int,
                               message msg: String?,
                               poiId poi: Int?,
                               completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        reportaProblemService(category: id, message: msg, poiId: poi)
    }
    
    private func reportaProblemService(category:Int, message: String?, poiId: Int?) {
        let t = TRPReportAProblemServices(categoryId: category,
                                          message: message,
                                          poiId: poiId)
        t.Completion = { result, error, _ in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let r = result as? TRPReportAProblemJsonModel {
                self.postData(result: r.data ?? nil)
            }
        }
        t.connection()
    }
}
