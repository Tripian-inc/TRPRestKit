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


/// The TRPRestKit is a framework of Tripian Api that allows you to create a trip and take information about places.
///
///  Framework provide you;
///  * Information of City
///  * Type of Cİty
///  * Information of Place
///  * Question of trip
///  * Take a recommendation
///  * User login/register/info
///  * User's trip
///  * Daily Plan
///  * Plan's place
///  * NearBy services
///
/// - seealso: [asda](https://www.tripian.com/apidocs/)
///
///
/// - precondition:
/// ```
///
/// TRPClient.provideApiKey(tripianApi)
///
/// TRPRestKit().city(withId:completionHandler:)
///
/// ```
///
@objc public class TRPRestKit:NSObject {
    
    /// This method hold a Result and Error object when the request is completed.
    public typealias CompletionHandler = (_ result:Any?, _ error: NSError?)-> Void;
    /// This method hold a Result, Error and Pagination object when the request is completed.
    public typealias CompletionHandlerWithPagination = (_ result:Any?, _ error: NSError?, _ pagination:Pagination?)-> Void;
    
    private var completionHandler: CompletionHandler?;
    private var completionHandlerWithPagination: CompletionHandlerWithPagination?;

    
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
    
    
    /// Obtain all city information.
    ///
    /// - Parameter completionHandler: Any objects needs to be converted to **[TRPCityInfoModel]** object.
    public func cities(completionHandler: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completionHandler;
        citiesServices(id: nil);
    }
    
    
    
    /// Obtain information of a city using City Id.
    ///
    /// - Parameters:
    ///   - id: City Id
    ///   - completion: A closer which will be called after request completes.
    /// - Important: Any objects needs to be converted to **TRPCityInfoModel** object.
    public func city(with id: Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        citiesServices(id: id);
    }
    
    
    
    /// #deneme#
    ///
    /// Obtain information of a city using user location.
    /// The nearest city is found by user location
    /// - Parameters:
    ///   - location: user's current location
    ///   - completionHandler: Any objects needs to be converted to **TRPCityInfoModel** object.
    public func city(with location: TRPLocation, completionHandler: @escaping CompletionHandler){
        self.completionHandler = completionHandler;
        citiesServices(location: location)
    }
    
    
    /// Obtain information of cities using link which returned from Pagination
    ///
    /// - Parameters:
    ///   - link: link that returned from Pagination
    ///   - completion: Any objects needs to be converted to **[TRPCityInfoModel]** object.
    public func city(link: String, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        citiesServices(id: nil,link: link);
    }
    
    
    /// A services that manage all task to connecting remote server
    ///
    /// - Parameters:
    ///   - id: city Id
    ///   - link: Link that returened from Pagination
    ///   - location: User current location
    ///   - limit: number of record to display
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
 
 
 // MARK: - Poi Categories Services
 extension TRPRestKit {
    
    
    /// Obtain the list of all categories, such as attractions, restaurants, cafes,
    /// bars, religious places, cool finds, shopping centers, museums, bakeries and art galleries.
    ///
    /// When you craete a Add Place List View(Eat&Drink, Attractions), you can use poi categories.
    /// PoiCategories can be matched **Place.categories**.
    ///
    /// - SeeAlso: [Api Doc](https://www.tripian.com/apidocs/#get-all-place-types)
    ///
    /// - Parameter completion: Any objects needs to be converted to **[TRPCategoryInfoModel]** object.
    public func poiCategories(completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiCategoriesServices(id: nil)
    }
    
    
    /// Obtain information of a pois categories using Category id.
    ///
    /// When you craete a Add Place List View(Eat&Drink, Attractions), you can use poi categories.
    /// PoiCategories can be matched **Place.categories**.
    ///
    /// - Parameters:
    ///   - withId: Category id
    ///   - completion: Any objects needs to be converted to **TRPCategoryInfoModel** object.
    public func poiCategories(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        poiCategoriesServices(id: withId);
    }
    
    
    /// A services that manage all task to connecting remote server
    ///
    /// - Parameter id: if id is no nil, service take a object.
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
            
            if let r = result as? TRPPoiCategories{
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
 
 
 // MARK: - Poi Services
 extension TRPRestKit {
    
    /// Obtain information of a poi using Poi Id.
    ///
    /// - Parameters:
    ///   - withId: unique poi id
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object.
    ///
    /// - Postcondition: Result array must be converted to single **(ar.first!)** object.
    public func poi(withId:Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        poiServices(placeIds: [withId], cities: nil)
    }
    
    
    /// Obtain information of pois using both poi ids and city id.
    /// All pois have to be in same city.
    ///
    /// - SeeAlso: [Api Doc](https://www.tripian.com/apidocs/#get-places)
    ///
    /// - Parameters:
    ///   - ids: poi ids
    ///   - cityId: city id
    ///   - autoPagination: if you set a `true`, next link will be continued automatically. If you set a `false`, next link will not be continued automatically. You must call **poi(link:complation:)** using `pagination.nextlink`.
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object. You must check Pagination value.
    public func poi(withIds ids:[Int],
                    cityId: Int,
                    autoPagination:Bool = true,
                    completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiServices(placeIds: ids, cities: [cityId], autoPagination: autoPagination)
    }
    
    
    /// Obtain all information of pois using city id.
    ///
    /// - Parameters:
    ///   - cityId: City Id
    ///   - limit: number of record to display
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object. You must check Pagination value.
    public func poi(withCityId cityId:Int,
                    limit:Int? = 100,
                    completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiServices(placeIds: nil, cities: [cityId],limit: limit)
    }
    
    
    /// Obtain information of pois using link which returned from Pagination
    ///
    /// - Parameters:
    ///   - link: Link that returened from Pagination
    ///   - limit: number of record to display
    ///   - autoPagination: if you set a `true`, next link will be continued automatically. If you set a `false`, next link will not be continued automatically. You must call **poi(link:complation:)** using `pagination.nextlink`.
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object. You must check Pagination value.
    public func poi(link: String, limit:Int? = 100, autoPagination:Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        poiServices(placeIds: nil, cities: nil, limit: limit, link: link, autoPagination:autoPagination)
    }
    
    
    /// Obtain information of pois using location. You can use this method to `Near By` in Add Place.
    /// The poi that nearest the coordinate is at the top.
    /// If you want obtain all poi, we suggest that categoryIds is nil.
    ///
    /// - Parameters:
    ///   - location: Center coordinate.
    ///   - distance: Defines the distance(in km) within which to return poi results.Default value: 50(km)
    ///   - cityId: City Id
    ///   - categoryId: Poi category id. You can use this method like `Near By` in `Add Place`.
    ///   - autoPagination: if you set a `true`, next link will be continued automatically. If you set a `false`, next link will not be continued automatically. You must call **poi(link:complation:)** using `pagination.nextlink`.
    ///   - limit: number of record to display
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object. You must check Pagination value.
    public func poi(withLocation location: TRPLocation,
                       distance: Double? = nil,
                       cityId: Int? = nil,
                       categoryId: Int,
                       autoPagination: Bool? = false,
                       limit: Int? = 25,
                       completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        poiServices(limit: limit,
                    location: location,
                    distance: distance,
                    typeId: categoryId,
                    cityId: cityId,
                    autoPagination: autoPagination ?? false)
    }
    
    
    /// Obtain information of pois using location. You can use this method to `Search This Area` button on the map view.
    /// The poi that nearest the coordinate is at the top.
    /// If you want obtain all poi, we suggest that categoryIds is nil.
    ///
    /// - Parameters:
    ///   - location: Center coordinate.
    ///   - distance: Defines the distance(in km) within which to return poi results.Default value: 50(km)
    ///   - cityId: City Id
    ///   - categoryIds: Poi category ids. You can use this method like `Search This Area` button on `Map View`.
    ///   - autoPagination: if you set a `true`, next link will be continued automatically. If you set a `false`, next link will not be continued automatically. You must call **poi(link:complation:)** using `pagination.nextlink`.
    ///   - limit: number of record to display
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object. You must check Pagination value.
    public func poi(withLocation location: TRPLocation,
                    distance: Double? = nil,
                    cityId: Int? = nil,
                    categoryIds: [Int]? = nil,
                    autoPagination: Bool? = false,
                    limit: Int? = 25,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        poiServices(limit: limit,
                    location: location,
                    distance: distance,
                    typeIds: categoryIds,
                    cityId: cityId,
                    autoPagination: autoPagination ?? false)
    }

    
    /// Obtain information of pois using search text such as tags(for example "restaurant", "museum", "bar" etc.), name of poi.
    ///
    /// - Parameters:
    ///   - search: Text
    ///   - cityId: City Id. If user is not in referans city, city id should be sent. When city id is sent, pois are sorted by distance.
    ///   - userLoc: User's coordinate. If userLocation is sent, pois are sorted by distance. CityId is not needed.
    ///   - completion: Any objects needs to be converted to **[TRPPoiInfoModel]** object. You must check Pagination value.
    public func poi(search: String,
                    cityId: Int? = nil,
                    location userLoc: TRPLocation? = nil,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion;
        poiServices(location: userLoc, searchText: search, cityId: cityId, autoPagination: false)
    }
    
    
    /// A services that manage all task to connecting remote server
    ///
    /// - Parameters:
    ///   - placeIds: Place id
    ///   - cities: cities Id
    ///   - limit:  number of record to display
    ///   - location: user current location
    ///   - distance: limit that location and distance between
    ///   - typeId: CategoryId
    ///   - typeIds: CategoriesIds
    ///   - link: Link for Pagination
    ///   - searchText: Search text parameter for tags or places name
    ///   - cityId: CityId
    ///   - autoPagination: AutoCompletion patameter
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
    
    
    /// Return a question which can be used when creating a trip by Question Id.
    ///
    /// - Parameters:
    ///   - questionId: Id of question
    ///   - completion: Any objects needs to be converted to **TRPTripQuestionInfoModel** object.
    public func tripQuestions(withQuestionId questionId: Int, completion: @escaping CompletionHandler){
        self.completionHandler = completion;
        questionServices(questionId: questionId)
    }
    
    
    /// Return questions which can be used when creating a trip by city Id.
    ///
    /// - Parameters:
    ///   - cityId: City Id
    ///   - type: type of Question such as `trip` and `profile`. Both `trip` and `profile` have be used when creating a trip. Profile can be used in `Localy Mode`.
    ///   - completion: Any objects needs to be converted to **[TRPTripQuestionInfoModel]** object.
    public func tripQuestions(withCityId cityId: Int,
                              type: TPRTripQuestionType? = TPRTripQuestionType.trip,
                              language: String? = nil,
                              completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        questionServices(cityId: cityId, type:type,language:language)
    }
    
    
    /// A services that manage all task to connecting remote server
    ///
    /// - Parameters:
    ///   - cityId: id of city
    ///   - questionId: id of question
    ///   - type: type of request. You can use Profile when opening add place in localy mode. You have to use Profile and Trip when creating a trip.
    private func questionServices(cityId:Int? = nil,
                                  questionId: Int? = nil,
                                  type: TPRTripQuestionType? = nil,
                                  language: String? = nil) {
        
        var t: TRPTripQuestion?
        if let cityId = cityId {
            t = TRPTripQuestion(cityId: cityId)
        }else if let questionId = questionId  {
            t = TRPTripQuestion(questionId: questionId)
        }
    
        guard let services = t else {return}
        services.language = language
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

 // MARK: - Quick Recommendation
extension TRPRestKit {
    
    
    /// Returns list of pois ids generated using TRPRecommendationSettings by Recommendation Engine.
    /// You can use `TRPRecommendationSettings(cityId:)`in `Localy Mode` but we suggest that uses `TRPRecommendationSettings(hash:)` in `Trip Mode`
    ///
    /// - Parameters:
    ///   - settings: A TRPRecommendationSettings object.
    ///   - autoPagination: if you set a `true`, next link will be continued automatically. If you set a `false`, next link will not be continued automatically. You must call **poi(link:complation:)** using `pagination.nextlink`.
    ///   - completion: Any objects needs to be converted to **[TRPRecommendationInfoJsonModel]** object.
    public func quickRecommendation(settings: TRPRecommendationSettings, autoPagination: Bool = true, completion: @escaping CompletionHandlerWithPagination){
        self.completionHandlerWithPagination = completion;
        recommendationServices(settings: settings, autoPagination: autoPagination)
    }
    
    /// Recommendation service
    private func recommendationServices(settings: TRPRecommendationSettings, autoPagination: Bool) {
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
    
    
    /// Obtain the access token for API calls that require user identification.
    ///
    /// If user login is successful, TRPUserPersistent object saves user accessToken.
    ///
    /// - Parameters:
    ///   - name: Name of User. The name parameters is automatically generated by Tripian.
    ///   - password: Password of User
    ///   - completion: Any objects needs to be converted to **TRPLoginInfoModel** object.
    public func login(email eMail:String, password: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(email: eMail, password: password)
    }
    
    public func loginTestServer(userName name: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(userName: name)
    }
    
    /// User Login service
    ///
    /// - Parameters:
    ///   - name: User name
    ///   - password: user password
    private func loginServices(email: String? = nil,
                               password: String? = nil,
                               userName: String? = nil) {
        var service: TRPLogin?
        
        if let email = email, let password = password {
            service = TRPLogin(email: email, password: password)
        }else if let userName = userName {
            service = TRPLogin(userName: userName)
        }
        guard let t = service else {return}
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
    
    /// User logout. TRPUserPersistent removes all accessToken.
    public func logout() {
        TRPUserPersistent.remove()
    }
    
 }

 
 // MARK: - User Register
 extension TRPRestKit {
    
    /// This method can be used to create a new User.
    /// Tripian Api generates a `userName` automatically.
    ///
    /// - Parameters:
    ///   - password: Password of user.
    ///   - completion: Any objects needs to be converted to **TRPUserInfoModel** object.
    public func register(email: String, password:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(email: email, password: password)
    }
    
    // returned TRPTestUserInfoModel
    public func registerOnTestServer(userName: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(userName: userName)
    }
    
    /// Return information about user such as eat and drink preferences
    ///
    /// - Parameter completion:  Any objects needs to be converted to **TRPUserInfoModel** object.
    public func userInfo(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userInfoServices(type: .getInfo)
    }
    
    /// A services that manage all task to connecting remote server
    private func userRegisterServices(email:String? = nil,
                                      password: String? = nil,
                                      userName: String? = nil) {
        var serverType = ""
        var services: TRPUserRegister?
        if let email = email, let password = password {
            serverType = "AirMiles"
            services = TRPUserRegister(email: email, password: password)
        }else if let userName = userName {
            serverType = "Test"
            services = TRPUserRegister(userName: userName)
        }
        guard let mServices = services else { return }
        mServices.Completion = {   (result, error,_) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if serverType == "AirMiles" {
                if let r = result as? TRPUserInfoJsonModel {
                    self.postData(result: r.data);
                }else {
                    self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
                }
            }else if serverType == "Test" {
                if let r = result as? TRPTestUserInfoJsonModel {
                    self.postData(result: r.data);
                }else {
                    self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
                }
            }
            
            
        }
        mServices.connection();
    }
    
 }
 
// MARK: Update User Info
extension TRPRestKit {
    
    
    /// Updates the user's answers. The answers change Recommendation Engine's working.
    ///
    /// - Parameters:
    ///   - answers: User answers of Trip
    ///   - completion: Any objects needs to be converted to **TRPUserInfoModel** object.
    public func updateUserAnswer(answers: [Int], completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(answers: answers, type: .updateAnswer)
    }
    
    /// A services that manage all task to connecting remote server
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
            t = TRPUserInfoServices(password: password, answers: answers)
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


// MARK: - Favorites of User's Poi.
extension TRPRestKit {

    
    /// This method is used to add poi to user's favorite list.
    ///
    /// - Parameters:
    ///   - cityId: Id of city where the poi is located.
    ///   - poiId: Id of Poi
    ///   - completion: Any objects needs to be converted to **TRPFavoritesInfoModel** object.
    public func addUserFavorite(cityId: Int, poiId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, poiId: poiId, mode: .add)
    }
    
    
    /// Returns Poi ids of user's favorite poi list.
    ///
    /// - Parameters:
    ///   - cityId: Id of city where the poi is located.
    ///   - completion: Any objects needs to be converted to **[TRPFavoritesInfoModel]** object.
    public func getUserFavorite(cityId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, mode: .get)
    }
    
    
    /// This method is used to delete poi to user's favorite list.
    ///
    /// - Parameters:
    ///   - cityId: Id of city where the poi is located.
    ///   - poiId: Id of Poi
    ///   - completion: Any objects needs to be converted to **TRPParentJsonModel** object.
    public func deleteUserFavorite(cityId: Int, poiId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, poiId: poiId, mode: .delete)
    }
    
    /// A services that manage all task to connecting remote server
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
    
    
    /// Returns all trips created by User.
    ///
    /// - Parameters:
    ///   - limit: number of record to display
    ///   - completion: Any objects needs to be converted to **TRPUserTripInfoModels** object.
    public func userTrips(limit:Int? = 100, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTripsServices(limit: 100)
    }
    
    /// A services that manage all task to connecting remote server
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
    
    /// To create a new trip for user.
    ///
    /// - Parameters:
    ///   - settings: Includes settings about a trip to create.
    ///   - completion: Any objects needs to be converted to **TRPTripInfoModel** object.
    public func createTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler){
        completionHandler = completion;
        createOrEditTripServices(settings: settings)
    }
    
    public func editTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        createOrEditTripServices(settings: settings)
    }
    
    /// A services that manage all task to connecting remote server
    private func createOrEditTripServices(settings: TRPTripSettings) {
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
    
    
    /// Returns foundation information about trip using hash.
    ///
    /// - Parameters:
    ///   - hash: hash of trip
    ///   - completion: Any objects needs to be converted to **TRPTripInfoModel** object.
    public func getTrip(withHash hash:String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getTripServices(hash: hash)
    }
    
    /// A services that manage all task to connecting remote server
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
    
    /// A services that manage all task to connecting remote server
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
    
    /// Return a day plan.
    ///
    /// - Parameters:
    ///   - id: id of plan
    ///   - completion: Any objects needs to be converted to **TRPDailyPlanInfoModel** object.
    public func dailyPlan(id:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        dailyPlanServices(id: id)
    }
    
    /// A services that manage all task to connecting remote server
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
    
    
    /// Provides adding a poi to the plan
    ///
    /// - Parameters:
    ///   - hash: hash of trip
    ///   - dailyPlanId: id of Plan
    ///   - poiId: new poi id
    ///   - order: pois order
    ///   - completion: Any objects needs to be converted to **TRPPlanPointInfoModel** object.
    public func addPlanPoints(hash: String, dailyPlanId: Int, poiId: Int, order: Int? = nil, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(hash: hash, dailyPlanId: dailyPlanId, placeId: poiId, order: order, type: TRPPlanPoints.Status.add)
    }
    
    ///TODO: BU KISIM İYİ ANLATILMALI. GÖRSEL OLARAK HAZIRLANMALI.
    public func replacePlanPoiFrom(dailyPlanPoiId: Int, poiId: Int? = nil, order: Int? = nil, completion: @escaping CompletionHandler ) {
        completionHandler = completion;
        planPointsServices(id: dailyPlanPoiId, placeId: poiId, order: order, type: .update)
    }
    
    
    public func reOrderPlanPoiFrom(dailyPlanPoiId: Int, poiId: Int, order: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(id: dailyPlanPoiId, placeId: poiId, order: order, type: .update)
    }
    
    
    /// Provides deleting a poi to the plan
    ///
    /// - Parameters:
    ///   - id: id of poi
    ///   - completion: Any objects needs to be converted to **TRPParentJsonModel** object.
    public func deleteDailyPlanPoi(planPoiId id:Int, completion: @escaping CompletionHandler) {
        completionHandler = completion;
        planPointsServices(id: id, type: .delete)
    }
    
    /// A services that manage all task to connecting remote server
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
                if let r = result as? TRPProgramStepJsonModel{
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
    
    /// A services that manage all task to connecting remote server
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

extension TRPRestKit {
    
    ///  Find
    ///
    /// - Parameters:
    ///   - key: Api key of Google
    ///   - text: Name of place to search.
    ///   - center: Boundary of City.
    ///   - radius: Search radius for limit.
    ///   - completion: Any objects needs to be converted to **[TRPGooglePlace]** object.
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
    
    /// A services that manage all task to connecting remote server
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
            }
        }
    }

}

extension TRPRestKit {
    
    /// Returns information of a place from Google Server with place's id.
    /// This method doesn't use Tripian Server.
    ///
    /// - Parameters:
    ///   - key: Google Place Api key
    ///   - id: id of Place that registered in Google
    ///   - completion: Any objects needs to be converted to **TRPGooglePlaceLocation** object.
    public func googlePlace(key:String, id: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googlePlaceServices(key:key, placeId: id)
    }
    
    /// A services that manage all task to connecting remote server
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
    
    
    /// Returns categories of problem such as incorrect location, incorrect name etc...
    ///
    /// - Parameter completion: Any objects needs to be converted to **[TRPProblemCategoriesInfoModel]** object.
    public func problemCategories(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        problemCategoriesService()
    }
    
    /// A services that manage all task to connecting remote server
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
    
    
    /// Report a problem about poi.
    ///
    /// - Parameters:
    ///   - id: id of category
    ///   - msg: mesage
    ///   - poi: id of poi
    ///   - completion: Any objects needs to be converted to **TRPReportAProblemInfoModel** object.
    public func reportaProblem(category name: String,
                               message msg: String?,
                               poiId poi: Int?,
                               completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        reportaProblemService(categoryName: name, message: msg, poiId: poi)
    }
    
    /// A services that manage all task to connecting remote server
    private func reportaProblemService(categoryName: String, message: String?, poiId: Int?) {
        let t = TRPReportAProblemServices(categoryName : categoryName,
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


extension TRPRestKit {
    
    public func updateDailyPlanHour(dailyPlanId: Int, start:String, end:String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        updateDailyPlanHourService(dailyPlanId: dailyPlanId, start: start, end: end)
    }
    
    private func updateDailyPlanHourService(dailyPlanId: Int, start:String, end:String) {
            let t = TRPDailyPlanServices(id: dailyPlanId, startTime: start, endTime: end)
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
