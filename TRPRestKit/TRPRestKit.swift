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
@objc public class TRPRestKit: NSObject {
    
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
    
    private var completionHandler: CompletionHandler?
    private var completionHandlerWithPagination: CompletionHandlerWithPagination?
    
    fileprivate func postData(result: Any?, pagination: Pagination? = Pagination.completed) {
        if let comp = completionHandler {
            comp(result, nil)
        } else if let withPagination = completionHandlerWithPagination {
            withPagination(result, nil, pagination)
        }
    }
    
    fileprivate func postError(error: NSError?, pagination: Pagination? = Pagination.completed) {
        if let comp = completionHandler {
            comp(nil, error)
        } else if let full = completionHandlerWithPagination {
            full(nil, error, pagination)
        }
    }
    
}

// MARK: - Cities Services
extension TRPRestKit {
    //TODO: Cities -> Burada completion handler larin isminin hep ayni olmasi lazim
    
    /// Obtain the list of all available cities with given limit, isAutoPagination(Optional) and completionHandler parameters.
    ///
    /// - Parameters:
    ///     - limit: Number of city that will be given.
    ///     - isAutoPagination: Boolean value whether pagination is required, default value is true.
    ///     - completionHandler: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Any Object needs to be converted to **[TRPCityInfoModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-all-available-cities)
    public func cities(limit: Int? = 25, isAutoPagination: Bool? = true, completionHandler: @escaping CompletionHandlerWithPagination) {
        //Fixme: - autoPagination eklenebilir.
        self.completionHandlerWithPagination = completionHandler
        citiesServices(id: nil, limit: limit, autoPagination: isAutoPagination)
    }
    
    /// Obtain the requested city with given cityId and completion parameters.
    ///
    /// Obtain information (such as ) on a specific city. Returned results include city_id, featured image, coordinates, country and continent.
    ///
    /// - Parameters:
    ///     - id: City Id that will be the id of required city.
    ///     - completionHandler: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPCityInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-details-of-a-city)
    public func city(with id: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        citiesServices(id: id)
    }
    
    /// Obtain the requested city with given user location and completionHandler parameters.
    ///
    /// The nearest city is found by requested location will be returned. Returned results include city_id, featured image, coordinates, country and continent.
    ///
    /// - Parameters:
    ///   - location: TRLocation object that will be given.
    ///   - completionHandler: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPCityInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#find-city-by-coordinates)
    public func city(with location: TRPLocation, completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
        citiesServices(location: location)
    }
    
    /// Obtain the list of all available cities with given url link and completion parameters.
    ///
    /// All the available cities from the requested url link will be given in the form of CompletionHandlerWithPagination.
    ///
    /// - Parameters:
    ///   - link: link that returned from Pagination
    ///   - completionHandler: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Any Object needs to be converted to **[TRPCityInfoModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-all-available-cities)
    public func cities(link: String, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        citiesServices(id: nil, link: link)
    }
    
    /// A services which will be used in cities services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///   - id: Id of the city (Optional).
    ///   - link: Link that will be returned from Pagination (Optional).
    ///   - location: User's current location (Optional).
    ///   - limit: number of city list to display (Optional).
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional).
    private func citiesServices(id: Int? = nil,
                                link: String? = nil,
                                location: TRPLocation? = nil,
                                limit: Int? = 25,
                                autoPagination: Bool? = true) {
        
        let cityService = createCitiesServices(id: id, link: link, location: location, limit: limit, autoPagination: autoPagination)
        guard let service = cityService else {return}
        service.limit = limit ?? 50
        if let autoPagination = autoPagination {
            service.isAutoPagination = autoPagination
        }
        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPCityJsonModel {
                if let cities = serviceResult.data {
                    if id != nil || location != nil {
                        if let city = cities.first {
                            self.postData(result: city, pagination: pagination)
                            return
                        }
                    } else {
                        self.postData(result: cities, pagination: pagination)
                        return
                    }
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        
        if let link = link {
            service.connection(link: link)
        } else {
            service.connection()
        }
    }
    
    private func createCitiesServices(id: Int? = nil,
                                      link: String? = nil,
                                      location: TRPLocation? = nil,
                                      limit: Int? = 25,
                                      autoPagination: Bool? = true) -> TRPCities? {
        var cityService: TRPCities?
        if id == nil && location == nil && link == nil {
            cityService = TRPCities()
        } else if let id = id {
            cityService = TRPCities(cityId: id)
        } else if let location = location {
            cityService = TRPCities(location: location)
        } else if limit != nil {
            cityService = TRPCities()
        }
        return cityService
    }
    
}

// MARK: - Poi Categories Services
extension TRPRestKit {
    
    /// Obtain the list of all categories, such as attractions, restaurants, cafes, bars,
    /// religious places, cool finds, shopping centers, museums, bakeries and art galleries. Returned results include category ids.
    ///
    /// Poi Categories is used during Add Place List operations (such as: Eat&Drink, Attractions, ...etc.).
    /// PoiCategories can be matched with **Place.categories**.
    ///
    /// - Parameters:
    ///     - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Any Object needs to be converted to **[TRPCategoryInfoModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#tripian-recommendation-engine-places-of-interest)
    public func poiCategories(completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        poiCategoriesServices(id: nil)
    }
    
    /// Obtain information on a specific Place of Interest by using POI id.
    /// Returned results include, POI id, city id, category id, name, address, coordinates,
    /// phone number, website, opening/closing times, tags, icon,
    /// description (if available), price range and images.
    ///
    /// - Parameters:
    ///     - withId: id of the Category that will be requested.
    ///     - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any object needs to be converted to **TRPCategoryInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-details-of-a-place)
    public func poiCategory(withId: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        poiCategoriesServices(id: withId)
    }
    
    /// A services which will be used in place of interests category services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///     - id: id of the Category (Optional).
    private func poiCategoriesServices(id: Int?) {
        var poiService: PoiCategories?
        if id == nil {
            poiService = PoiCategories()
        } else {
            poiService = PoiCategories(typeId: id!)
        }
        poiService?.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let serviceResult = result as? TRPPoiCategories {
                if let types = serviceResult.data {
                    if id == nil {
                        self.postData(result: types, pagination: pagination)
                        return
                    } else {
                        if let type = types.first {
                            self.postData(result: type, pagination: pagination)
                            return
                        }
                    }
                }
                
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        poiService?.connection()
    }
}

// MARK: - Poi Services
extension TRPRestKit {
    
    /// Obtain the list of all Place of interests.
    /// Returned results include, POI id, city id, category id, name, address,
    /// coordinates, phone number, website, opening/closing times, tags, icon, description (if available), price range and images.
    /// Use city id to obtain Places of interests of a specific city.
    /// Use coordinates to obtain nearby POIs (use category or distance parameters to filter)
    ///
    /// All pois must be in the same city.
    ///
    /// - Parameters:
    ///   - withIds: Places of Interests in a form of array.
    ///   - cityId: Id of the requested city.
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional), in a detailed manner,
    ///   if the autopagination is set to `true`, next link will be continued.
    ///   If autopagination is set to `false`, next link will not be continued.
    ///   To call **poi(link:complation:)**, `pagination.nextlink` must be used.
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any object needs to be converted to **[TRPPoiInfoModel]** object.
    ///  Pagination value also must be checked.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-places)
    public func poi(withIds ids: [Int],
                    cityId: Int,
                    autoPagination: Bool = true,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        poiServices(placeIds: ids, cities: [cityId], autoPagination: autoPagination)
    }
    
    
    /// Obtain all information of pois using city id.
    ///
    /// - Parameters:
    ///   - cityId: City Id
    ///   - limit: number of poi list to display (Optional).
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional), in a detailed manner,
    ///   if the autopagination is set to `true`, next link will be continued.
    ///   If autopagination is set to `false`, next link will not be continued.
    ///   To call **poi(link:complation:)**, `pagination.nextlink` must be used.
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any object needs to be converted to **[TRPPoiInfoModel]** object.
    ///  Pagination value also must be checked.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-places)
    public func poi(withCityId cityId: Int,
                    limit: Int? = 100,
                    autoPagination: Bool? = false,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        
        poiServices(placeIds: nil,
                    cities: [cityId], limit: limit,
                    autoPagination: autoPagination ?? false)
    }
    
    /// Obtain information of pois using url link which will be returned from Pagination
    ///
    /// - Parameters:
    ///   - link: Link that returned from Pagination
    ///   - limit: number of poi list to display (Optional).
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional), in a detailed manner,
    ///   if the autopagination is set to `true`, next link will be continued.
    ///   If autopagination is set to `false`, next link will not be continued.
    ///   To call **poi(link:complation:)**, `pagination.nextlink` must be used.
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any object needs to be converted to **[TRPPoiInfoModel]** object.
    ///  Pagination value also must be checked.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-places)
    public func poi(link: String, limit: Int? = 100, autoPagination: Bool = true, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        poiServices(placeIds: nil, cities: nil, limit: limit, link: link, autoPagination: autoPagination)
    }
    
    /// Obtain information of pois using location.
    ///
    /// This method is used when tapped in `Search This Area` button on the map view.
    /// The pois are ordered by the nearest cordinate,
    /// so that the first poi will be the closest one to the requested location.
    /// If all the pois are requested in the call, categoryIds parameter must be nil.
    ///
    /// - Parameters:
    ///   - location: TRLocation object that will be given.
    ///   - distance: Double value which will return pois in requested distance km. (Optional, default value is 50(km)).
    ///   - cityId: Id of the requested city.
    ///   - categoryIds: Poi category ids. This parameter is used in `Search This Area` button action on `Map View`.
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional), in a detailed manner,
    ///   if the autopagination is set to `true`, next link will be continued.
    ///   If autopagination is set to `false`, next link will not be continued.
    ///   To call **poi(link:complation:)**, `pagination.nextlink` must be used.
    ///   - limit: number of pois to display (Optional).
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any object needs to be converted to **[TRPPoiInfoModel]** object.
    ///  Pagination value also must be checked.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-places)
    public func poi(withLocation location: TRPLocation,
                    distance: Double? = nil,
                    cityId: Int? = nil,
                    categoryIds: [Int]? = nil,
                    autoPagination: Bool? = false,
                    limit: Int? = 25,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        poiServices(limit: limit,
                    location: location,
                    distance: distance,
                    typeIds: categoryIds,
                    cityId: cityId,
                    autoPagination: autoPagination ?? false)
    }
    
    /// Obtain information of pois using city Id.
    ///
    ///
    /// - Parameters:
    ///   - withCityId: Id of the requested city.
    ///   - categoryIds: Poi category ids. This parameter is used in `Search This Area` button action on `Map View`.
    ///   - autoPagination: bool value to declare whether pagination is requested or not (Optional), in a detailed manner,
    ///   if the autopagination is set to `true`, next link will be continued.
    ///   If autopagination is set to `false`, next link will not be continued.
    ///   To call **poi(link:complation:)**, `pagination.nextlink` must be used.
    ///   - limit: number of pois to display (Optional).
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any object needs to be converted to **[TRPPoiInfoModel]** object.
    ///  Pagination value also must be checked.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-places)
    public func poi(withCityId: Int,
                    categoryIds: [Int]? = nil,
                    autoPagination: Bool? = false,
                    limit: Int? = 25,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        poiServices(limit: limit,
                    typeIds: categoryIds,
                    cityId: withCityId,
                    autoPagination: autoPagination ?? false)
    }
    
   
    /// Obtain information of pois using search text such as tags(for example "restaurant", "museum", "bar" etc.), name of poi.
    ///
    ///
    /// - Parameters:
    ///   - search: Text such as tags(for example "restaurant", "museum", "bar" etc.), name of poi.
    ///   - cityId: Id of City(Optional). If user is not in the referanced city, city id should not be sent. When city id is sent, pois are sorted by distance.
    ///   - userLoc: TRPLocation object that refers to user's coordinate. If userLocation is sent, pois are sorted by distance, in that case, CityId is not needed.
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any object needs to be converted to **[TRPPoiInfoModel]** object.
    ///  Pagination value also must be checked.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#get-places)
    public func poi(search: String,
                    cityId: Int? = nil,
                    location userLoc: TRPLocation? = nil,
                    completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        poiServices(location: userLoc, searchText: search, cityId: cityId, autoPagination: false)
    }
    
    /// A services which will be used in place of interests services, manages all task connecting to remote server.
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
                             autoPagination: Bool = true) {
        
        let placeService = createPoiService(placeIds: placeIds,
                                            cities: cities,
                                            limit: limit,
                                            location: location,
                                            distance: distance,
                                            typeId: typeId,
                                            typeIds: typeIds,
                                            link: link,
                                            searchText: searchText,
                                            cityId: cityId,
                                            autoPagination: autoPagination)
        
        guard let services = placeService else {return}
        services.isAutoPagination = autoPagination
        services.limit = limit ?? 25
        services.completion = {    (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPPoiJsonModel {
                if let places = serviceResult.data {
                    self.postData(result: places, pagination: pagination)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        
        if let link = link {
            services.connection(link: link)
        } else {
            services.connection()
        }
    }
    
    private func createPoiService(placeIds: [Int]? = nil,
                                  cities: [Int]? = nil,
                                  limit: Int? = 25,
                                  location: TRPLocation? = nil,
                                  distance: Double? = nil,
                                  typeId: Int? = nil,
                                  typeIds: [Int]? = nil,
                                  link: String? = nil,
                                  searchText: String? = nil,
                                  cityId: Int? = nil,
                                  autoPagination: Bool = true) -> TRPPlace? {
        var placeService: TRPPlace?
        if let places = placeIds, let cities = cities, let city = cities.first {
            placeService = TRPPlace(ids: places, cityId: city)
        } else if let search = searchText {
            placeService = TRPPlace(location: location,
                                    searchText: search,
                                    cityId: cityId)
        } else if let location = location {
            placeService = TRPPlace(location: location, distance: distance)
            if let id = typeId {
                placeService?.typeId = id
            }
            if let ids = typeIds {
                placeService?.typeIds = ids
            }
            placeService?.cityId = cityId
        } else if let cities = cities {
            placeService = TRPPlace(cities: cities)
        } else if link != nil {
            placeService = TRPPlace()
        } else if let cityId = cityId, let types = typeIds {
            placeService = TRPPlace(cityId: cityId, typeIds: types)
        }
        return placeService
    }
    
}

// MARK: - Question Services
extension TRPRestKit {

    /// Returns a question which will be used when creating a trip by requested Question Id.
    ///
    /// - Parameters:
    ///   - questionId: Id of the requested question.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    ///  - Important: Any object needs to be converted to **TRPTripQuestionInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#tripian-recommendation-engine-trip-planner)
    public func tripQuestions(withQuestionId questionId: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        questionServices(questionId: questionId)
    }
    
    /// Returns question array which will be used when creating a trip by requested city Id.
    ///
    /// - Parameters:
    ///   - cityId: Id of the requested City.
    ///   - type: type is an enumaration value that can be `trip` or `profile`.
    ///   Both `trip` and `profile` types are used when creating a trip. `profile` type  is used in user's profile questions.
    ///   - language: language is a String value to declare returned questions language (Optional).
    ///   Currently `French` and `English` are available.
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any Object needs to be converted to **[TRPTripQuestionInfoModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#tripian-recommendation-engine-trip-planner)
    public func tripQuestions(withCityId cityId: Int,
                              type: TPRTripQuestionType? = TPRTripQuestionType.trip,
                              language: String? = nil,
                              completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        questionServices(cityId: cityId, type: type, language: language)
    }

    /// Returns question array with type, language and completion handler parameters which will be used during creating trips.
    ///
    /// - Parameters:
    ///   - cityId: Id of the requested City.
    ///   - type: type is an enumaration value that can be `trip` or `profile`.
    ///   Both `trip` and `profile` types are used when creating a trip. `profile` type  is used in user's profile questions.
    ///   - language: language is a String value to declare returned questions language (Optional).
    ///   Currently `French` and `English` are available.
    ///   - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    ///  - Important: Any Object needs to be converted to **[TRPTripQuestionInfoModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#tripian-recommendation-engine-trip-planner)
    public func tripQuestions(type: TPRTripQuestionType? = TPRTripQuestionType.profile,
                              language: String? = nil,
                              completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        questionServices(type: type, language: language)
    }
    
    /// A services which will be used in question services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///   - cityId: id of city
    ///   - questionId: id of question
    ///   - type: type of request. You can use Profile when opening add place in localy mode. You have to use Profile and Trip when creating a trip.
    private func questionServices(cityId: Int? = nil,
                                  questionId: Int? = nil,
                                  type: TPRTripQuestionType? = nil,
                                  language: String? = nil) {
        
        var questionService: TRPTripQuestion?
        if let cityId = cityId {
            questionService = TRPTripQuestion(cityId: cityId)
        } else if let questionId = questionId {
            questionService = TRPTripQuestion(questionId: questionId)
        } else {
            questionService = TRPTripQuestion(tripType: type ?? .trip)
        }
        
        guard let services = questionService else {return}
        services.language = language
        services.tripType = type ?? .trip
        services.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPTripQuestionJsonModel {
                if let questions = serviceResult.data {
                    if questionId != nil {
                        if let quesion = questions.first {
                            self.postData(result: quesion)
                            return
                        }
                    } else {
                        self.postData(result: questions, pagination: pagination)
                        return
                    }
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        services.connection()
    }
    
}

// MARK: - Quick Recommendation
extension TRPRestKit {
    
    /// Returns TRPRecommendationInfoJsonModel list generated by requested TRPRecommendationSettings object.
    ///
    /// `TRPRecommendationSettings(cityId:)` declaration can be used in `Localy Mode`.
    ///  However, in `Trip Mode`,  usage with `TRPRecommendationSettings(hash:)` declaration is suggested.
    ///
    /// - Parameters:
    ///      - settings: A TRPRecommendationSettings object which is retrieved by Recommendation Engine.
    ///      - autoPagination: bool value to declare whether pagination is requested or not (Optional), in a detailed manner,
    ///      if the autopagination is set to `true`, next link will be continued.
    ///      If autopagination is set to `false`, next link will not be continued.
    ///      To call **poi(link:complation:)**, `pagination.nextlink` must be used.
    ///      - completion: A closer in the form of CompletionHandlerWithPagination will be called after request is completed.
    /// - Important: Any Object needs to be converted to **[TRPRecommendationInfoJsonModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#tripian-recommendation-engine-quick-recommendations)
    public func quickRecommendation(settings: TRPRecommendationSettings, autoPagination: Bool = true, completion: @escaping CompletionHandlerWithPagination) {
        self.completionHandlerWithPagination = completion
        recommendationServices(settings: settings, autoPagination: autoPagination)
    }
    
    /// A services which will be used in recommendation services, manages all task connecting to remote server.
    private func recommendationServices(settings: TRPRecommendationSettings, autoPagination: Bool) {
        let recommendationService = TRPRecommendation(settings: settings)
        recommendationService.isAutoPagination = autoPagination
        recommendationService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPRecommendationJsonModel, let recommendationPlaces = serviceResult.data {
                self.postData(result: recommendationPlaces, pagination: pagination)
            } else {
                self.postData(result: [], pagination: pagination)
            }
        }
        recommendationService.connection()
    }
    
}

// MARK: - USER LOGIN
extension TRPRestKit {
    
    /// Obtain the access token for API calls that require user identification.
    /// When login operation is successful, TRPUserPersistent object is saved in user accessToken.
    ///
    /// - Parameters:
    ///   - email: Username of the user which usually refers to email address of the user.
    ///   - password: Password of the user.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPLoginInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-login-as-a-user-)
    public func login(email eMail: String, password: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(email: eMail, password: password)
    }
    
    //TODO: Bu methodu public yapmak gerekiyor mu?
    public func loginTestServer(userName name: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        loginServices(userName: name)
    }
    
    /// A services which will be used in login services, manages all task connecting to remote server.
    ///
    /// - Parameters:
    ///   - name: User name
    ///   - password: user password
    ///   - userName: user name //TODO: Burada bir sorun var hem name hem username ayni sey degilmi? Yukaridaki login testserviceden dolayi geldiyse, name i tamamen kaldirip user name i birakmak mumkunmu?
    private func loginServices(email: String? = nil,
                               password: String? = nil,
                               userName: String? = nil) {
        var loginService: TRPLogin?
        
        if let email = email, let password = password {
            loginService = TRPLogin(email: email, password: password)
        } else if let userName = userName {
            loginService = TRPLogin(userName: userName)
        }
        guard let service = loginService else {return}
        service.completion = {    (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPLoginJsonModel {
                TRPUserPersistent.saveHashToken(serviceResult.data.accessToken)
                self.postData(result: serviceResult.data, pagination: pagination)
            } else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        service.connection()
    }
    
    /// User logout. TRPUserPersistent removes all accessToken.
    public func logout() {
        TRPUserPersistent.remove()
    }
    
}

// MARK: - User Register
extension TRPRestKit {
    
    /// Create a new user (customer) by posting the required parameters indicated below. No extra step needed to active the new user.
    /// Tripian Api generates a `userName` automatically refer to user's email address.
    ///
    /// - Parameters:
    ///   - email: Username of the user which usually refers to email address of the user.
    ///   - password: Password of the user.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPUserInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-register-a-user-)
    public func register(email: String, password: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(email: email, password: password)
    }
    
    // Below function is used in registering user on the test server.
    public func registerOnTestServer(userName: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userRegisterServices(userName: userName)
    }

    /// Obtain personal user information (must be logged in with access token), such as user id, e-mail, and preferences.
    ///
    /// - Parameters:
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPUserInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-get-current-user-information)
    public func userInfo(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        userInfoServices(type: .getInfo)
    }
    
    /// A services which will be used in user register services, manages all task connecting to remote server.
    private func userRegisterServices(email: String? = nil,
                                      password: String? = nil,
                                      userName: String? = nil) {
        var serverType = ""
        var services: TRPUserRegister?
        if let email = email, let password = password {
            serverType = "AirMiles"
            services = TRPUserRegister(email: email, password: password)
        } else if let userName = userName {
            serverType = "Test"
            services = TRPUserRegister(userName: userName)
        }
        guard let mServices = services else { return }
        mServices.completion = {   (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if serverType == "AirMiles" {
                if let resultService = result as? TRPUserInfoJsonModel {
                    self.postData(result: resultService.data)
                } else {
                    self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
                }
            } else if serverType == "Test" {
                if let serviceResult = result as? TRPTestUserInfoJsonModel {
                    self.postData(result: serviceResult.data)
                } else {
                    self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
                }
            }
            
        }
        mServices.connection()
    }
    
}

// MARK: Update User Info
extension TRPRestKit {
    
    //TODO: Mobilde kullanicinin adini tamamen silip kaydet deyince kullanicinin adinin ilk harfini sadece kayitli birakiyor. Burada butun adin eskisi gibi kalmasi dogru degilmi?
    //TODO: Appde user preferences degisince bu sizin future triplerinizi etkileyecek diyoruz ama tam anlamiyla future tripleri etkilemiyor?
    
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
    /// - Important: Any Object needs to be converted to **TRPUserInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-update-current-user-information)
    public func updateUserInfo(firstName: String?,
                               lastName: String?,
                               age: Int? = nil,
                               password: String? = nil,
                               answers: [Int]? = nil,
                               completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(firstName: firstName,
                         lastName: lastName,
                         age: age,
                         password: password,
                         answers: answers,
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
    /// - Important: Any Object needs to be converted to **TRPUserInfoModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-update-current-user-information)
    public func updateUserAnswer(answers: [Int], completion: @escaping CompletionHandler) {
        completionHandler = completion
        userInfoServices(answers: answers, type: .updateAnswer)
    }
    
  
    /// A services which will be used in user info services, manages all task connecting to remote server.
    private func userInfoServices(firstName: String? = nil,
                                  lastName: String? = nil,
                                  age: Int? = nil,
                                  password: String? = nil,
                                  answers: [Int]? = nil,
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
                                              age: age,
                                              password: password,
                                              answers: answers)
        }
        
        guard let services = infoService else {return}
        
        services.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPUserInfoJsonModel {
                self.postData(result: serviceResult.data, pagination: pagination)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        services.connection()
    }
    
}

// MARK: - Companions.
extension TRPRestKit {
    
    //TODO: Asagidaki companion servislerinde update de (id:) parametresi var, removeda (companionId:) parametresi var ikisinin ayni olmasi daha guzel olur
    //TODO: Api de delete companion burada remove companion ismi kullaniliyor.
    
    /// Add companion by adding name(Optional), age(Optional), Answers(Optional) and completion parameters.
    ///
    ///
    /// - Parameters:
    ///   - name: A String that refers to name of the companion (Optional).
    ///   - age: An Integer that refers to age of the companion (Optional).
    ///   - answers: An Integer array that refers to preferences of the companion (Optional).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPCompanionModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-add-companion)
    public func addCompanion(name: String?,
                             age: Int?,
                             answers: [Int]?,
                             completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        let serviceType = CompanionServiceType.add
        companionServices(name: name, age: age, answers: answers, serviceType: serviceType)
    }
    
    /// Update companion information (must be logged in with access token), such as name and answers
    ///
    /// - Parameters:
    ///   - id: An Integer that refers to id of the given companion.
    ///   - name: A String that refers to name of the given companion (Optional).
    ///   - age: An Integer that refers to age of the given companion (Optional).
    ///   - answers: An Integer array that refers to preferences of the given companion (Optional).
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPCompanionModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-update-companion)
    public func updateCompanion(id: Int,
                                name: String?,
                                age: Int?,
                                answers: [Int]?, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        let serviceType = CompanionServiceType.update
        companionServices(id: id,
                          name: name,
                          age: age,
                          answers: answers,
                          serviceType: serviceType)
    }
    
    /// Delete companion by adding companionId and completion parameters.
    ///
    /// - Parameters:
    ///   - companionId: An Integer that refers to id of the given companion that is going to be deleted.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Any Object needs to be converted to **TRPCompanionModel** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-update-companion)
    public func removeCompanion(companionId: Int, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        let serviceType = CompanionServiceType.delete
        companionServices(id: companionId, serviceType: serviceType)
    }
    
    /// Obtain user companions (must be logged in with access token), such as companion name, answers.
    ///
    /// - Parameters:
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important:Any Object needs to be converted to **[TRPCompanionModel]** object.
    /// - See Also: [Api Doc](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#how-to-get-companions)
    public func getUsersCompanions(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        let serviceType = CompanionServiceType.get
        companionServices(serviceType: serviceType)
    }
    
    /// A services which will be used in creating companion services, manages all task connecting to remote server.
    private func createCompanionServices(id: Int? = 0, name: String? = nil, age: Int? = nil, answers: [Int]? = nil, serviceType: CompanionServiceType) -> TRPCompanionServices? {
        var companionService: TRPCompanionServices?
        
        if serviceType == CompanionServiceType.add {
            companionService = TRPCompanionServices(serviceType: serviceType,
                                                    name: name,
                                                    answers: answers,
                                                    age: age)
        } else if serviceType == CompanionServiceType.get {
            companionService = TRPCompanionServices(serviceType: serviceType)
        } else if serviceType == CompanionServiceType.delete, let id = id {
            companionService = TRPCompanionServices(id: id, serviceType: serviceType)
        } else {
            guard let id = id else {return nil}
            companionService = TRPCompanionServices(serviceType: serviceType,
                                                    id: id,
                                                    name: name,
                                                    answers: answers,
                                                    age: age)
        }
        return companionService
    }
    
    /// A services which will be used in getting all companions, manages all task connecting to remote server.
    private func companionServices(id: Int? = 0,
                                   name: String? = nil,
                                   age: Int? = nil,
                                   answers: [Int]? = nil,
                                   serviceType: CompanionServiceType) {
        
        let companionService = createCompanionServices(id: id, name: name, age: age, answers: answers, serviceType: serviceType)
        guard let service = companionService else {
            self.postError(error: TRPErrors.objectIsNil(name: "TRPCompanionServices") as NSError)
            return
        }
        
        service.completion = {(result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if serviceType == .delete || serviceType == .update {
                if let serviceResult = result as? TRPParentJsonModel {
                    self.postData(result: serviceResult)
                    return
                }
            } else if serviceType == .add {
                if let serviceResult = result as? TRPCompanionsJsonModel {
                    if let model = serviceResult.data?.first {
                        self.postData(result: model)
                    }
                    
                    return
                }
            } else if serviceType == .get {
                if let serviceResult = result as? TRPCompanionsJsonModel {
                    self.postData(result: serviceResult.data)
                    return
                }
            }
            
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        service.connection()
    }
}

// MARK: - Favorites of User's Poi.
extension TRPRestKit {
    
    /// This method is used to add poi to user's favorite list.
    ///
    /// - Parameters:
    ///   - cityId: Id of city where the poi is located.
    ///   - poiId: Id of Poi
    ///   - completion: Any Object needs to be converted to **TRPFavoritesInfoModel** object.
    public func addUserFavorite(cityId: Int, poiId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, poiId: poiId, mode: .add)
    }
    
    /// Returns Poi ids of user's favorite poi list.
    ///
    /// - Parameters:
    ///   - cityId: Id of city where the poi is located.
    ///   - completion: Any Object needs to be converted to **[TRPFavoritesInfoModel]** object.
    public func getUserFavorite(cityId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, mode: .get)
    }
    
    /// This method is used to delete poi to user's favorite list.
    ///
    /// - Parameters:
    ///   - cityId: Id of city where the poi is located.
    ///   - poiId: Id of Poi
    ///   - completion: Any Object needs to be converted to **TRPParentJsonModel** object.
    public func deleteUserFavorite(cityId: Int, poiId: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        userFavoriteServices(cityId: cityId, poiId: poiId, mode: .delete)
    }
    
    /// A services that manage all task to connecting remote server
    private func userFavoriteServices(cityId: Int, poiId: Int? = nil, mode: TRPUserFavorite.Mode) {
        
        var favoriteService: TRPUserFavorite?
        if mode == .add || mode == .delete {
            if let poi = poiId {
                favoriteService = TRPUserFavorite(cityId: cityId, poiId: poi, type: mode)
            }
        } else if mode == .get {
            favoriteService = TRPUserFavorite(cityId: cityId)
        }
        
        guard let services = favoriteService else {return}
        services.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if mode == .delete {
                if let resultService = result as? TRPParentJsonModel {
                    self.postData(result: resultService)
                    return
                }
            } else {
                if let resultService = result as? TRPFavoritesJsonModel {
                    if mode == .add {
                        if let first = resultService.data?.first {
                            self.postData(result: first)
                            return
                        }
                    } else {
                        self.postData(result: resultService.data, pagination: pagination)
                        return
                    }
                }
            }
            
            self.postError(error: TRPErrors.wrongData as NSError)
        }
        services.connection()
    }
}

// MARK: - User Trips
extension TRPRestKit {
    
    /// Returns all trips created by User.
    ///
    /// - Parameters:
    ///   - limit: number of record to display
    ///   - completion: Any Object needs to be converted to **TRPUserTripInfoModels** object.
    public func userTrips(limit: Int? = 100, completion: @escaping CompletionHandlerWithPagination) {
        completionHandlerWithPagination = completion
        userTripsServices(limit: 100)
    }
    
    /// A services that manage all task to connecting remote server
    private func userTripsServices(limit: Int) {
        let tripService = TRPUserTrips()
        tripService.limit = limit
        tripService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let serviceResult = result as? TRPUserTripsJsonModel {
                self.postData(result: serviceResult.data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        tripService.connection()
    }
    
}

// MARK: - Constants
extension TRPRestKit {
    
    /// Returns all constants.
    ///
    /// - Parameters:
    ///   - completion: Any Object needs to be converted to **TRPUserTripInfoModels** object.
    public func getConstants(completion: @escaping CompletionHandler) {
        completionHandler = completion
        constantServices()
    }
    
    /// A services that manage all task to connecting remote server
    private func constantServices() {
        let constantsService = TRPConstantsServices()
        constantsService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceReuslt = result as? TRPConstantsParentJsonModel {
                self.postData(result: serviceReuslt.data?.constants)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        constantsService.connection()
    }
    
}

// MARK: - Version
extension TRPRestKit {
    
    /// Return version detail.
    ///
    /// - Parameters:
    ///   - completion: Any Object needs to be converted to **TRPUserTripInfoModels** object.
    public func getVersion(completion: @escaping CompletionHandler) {
        completionHandler = completion
        versionServices()
    }
    
    /// A services that manage all task to connecting remote server
    private func versionServices() {
        
        let constantsService = TRPConstantsServices()
        constantsService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPConstantsParentJsonModel {
                self.postData(result: serviceResult.data?.version)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        constantsService.connection()
    }
    
}

// MARK: - Trip
extension TRPRestKit {
    
    /// To create a new trip for user.
    ///
    /// - Parameters:
    ///   - settings: Includes settings about a trip to create.
    ///   - completion: Any Object needs to be converted to **TRPTripInfoModel** object.
    public func createTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion
        createOrEditTripServices(settings: settings)
    }
    
    public func editTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion
        createOrEditTripServices(settings: settings)
    }
    
    /// A services that manage all task to connecting remote server
    private func createOrEditTripServices(settings: TRPTripSettings) {
        let programService = TRPProgram(setting: settings)
        programService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let data = result as? TRPTripJsonModel, let serviceResult = data.data {
                self.postData(result: serviceResult)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        programService.connection()
    }
    
    /// Returns foundation information about trip using hash.
    ///
    /// - Parameters:
    ///   - hash: hash of trip
    ///   - completion: Any Object needs to be converted to **TRPTripInfoModel** object.
    public func getTrip(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getTripServices(hash: hash)
    }
    
    /// A services that manage all task to connecting remote server
    private func getTripServices(hash: String) {
        let getProgramService = TRPGetProgram(hash: hash)
        getProgramService.completion = {  (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPTripJsonModel, let info = serviceResult.data {
                self.postData(result: info)
            }
        }
        getProgramService.connection()
    }
    
    public func deleteTrip(hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteTripServices(hash: hash)
    }
    
    /// A services that manage all task to connecting remote server
    private func deleteTripServices(hash: String) {
        let deleteService = TRPDeleteProgram(hash: hash)
        deleteService.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPParentJsonModel {
                self.postData(result: serviceResult)
            }
        }
        deleteService.connection()
    }
    
}

// MARK: - Daily Plan
extension TRPRestKit {
    
    /// Return a day plan.
    ///
    /// - Parameters:
    ///   - id: id of plan
    ///   - completion: Any Object needs to be converted to **TRPDailyPlanInfoModel** object.
    public func dailyPlan(id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        dailyPlanServices(id: id)
    }
    
    /// A services that manage all task to connecting remote server
    private func dailyPlanServices(id: Int) {
        let dailyPlanServices = TRPDailyPlanServices(id: id)
        dailyPlanServices.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPDayPlanJsonModel {
                self.postData(result: serviceResult.data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        dailyPlanServices.connection()
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
    ///   - completion: Any Object needs to be converted to **TRPPlanPointInfoModel** object.
    public func addPlanPoints(hash: String, dailyPlanId: Int, poiId: Int, order: Int? = nil, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointsServices(hash: hash, dailyPlanId: dailyPlanId, placeId: poiId, order: order, type: TRPPlanPoints.Status.add)
    }
    
    ///TODO: BU KISIM İYİ ANLATILMALI. GÖRSEL OLARAK HAZIRLANMALI.
    public func replacePlanPoiFrom(dailyPlanPoiId: Int, poiId: Int? = nil, order: Int? = nil, completion: @escaping CompletionHandler ) {
        completionHandler = completion
        planPointsServices(id: dailyPlanPoiId, placeId: poiId, order: order, type: .update)
    }
    
    public func reOrderPlanPoiFrom(dailyPlanPoiId: Int, poiId: Int, order: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointsServices(id: dailyPlanPoiId, placeId: poiId, order: order, type: .update)
    }
    
    /// Provides deleting a poi to the plan
    ///
    /// - Parameters:
    ///   - id: id of poi
    ///   - completion: Any Object needs to be converted to **TRPParentJsonModel** object.
    public func deleteDailyPlanPoi(planPoiId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointsServices(id: id, type: .delete)
    }
    
    /// A services that manage all task to connecting remote server
    private func planPointsServices(hash: String? = nil,
                                    id: Int? = nil,
                                    dailyPlanId: Int? = nil,
                                    placeId: Int? = nil,
                                    order: Int? = nil, type: TRPPlanPoints.Status) {
        var planPointService: TRPPlanPoints?
        
        if type == TRPPlanPoints.Status.delete, let id = id {
            planPointService = TRPPlanPoints(id: id, type: type)
        } else if type == TRPPlanPoints.Status.add, let hash = hash, let dailyPlanId = dailyPlanId, let placeId = placeId {
            planPointService = TRPPlanPoints(hash: hash, dailyPlanId: dailyPlanId, placeId: placeId, order: order)
        } else if type == TRPPlanPoints.Status.update, let id = id {
            planPointService = TRPPlanPoints(id: id, placeId: placeId, order: order)
        }
        
        guard let service = planPointService else {
            self.postError(error: TRPErrors.objectIsNil(name: "TRPPlanPoints") as NSError)
            return
        }
        
        service.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if type == .delete {
                if let serviceResult = result as? TRPParentJsonModel {
                    self.postData(result: serviceResult, pagination: pagination)
                    return
                }
            } else if type == .add {
                if let serviceResult = result as? TRPProgramStepJsonModel {
                    self.postData(result: serviceResult.data, pagination: pagination)
                    return
                }
                
            } else {
                if let serviceResult = result as? TRPProgramStepJsonModel, let data = serviceResult.data {
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
        completionHandler = completion
        planPointAlternative(planPointId: id)
    }
    
    public func planPoiAlternatives(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointAlternative(hash: hash)
    }
    
    public func planPoiAlternatives(withDailyPlanId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointAlternative(dailyPlanId: id)
    }
    
    /// A services that manage all task to connecting remote server
    private func planPointAlternative(planPointId: Int? = nil, hash: String? = nil, dailyPlanId: Int? = nil) {
        var poiAlternativeService: TRPPlanPointAlternatives?
        
        if let planPointId = planPointId {
            poiAlternativeService = TRPPlanPointAlternatives(planPointId: planPointId)
        } else if let hash = hash {
            poiAlternativeService = TRPPlanPointAlternatives(hash: hash)
        } else if let dailyPlanId = dailyPlanId {
            poiAlternativeService =  TRPPlanPointAlternatives(dailyPlanId: dailyPlanId)
        }
        
        guard let service = poiAlternativeService else {return}
        service.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPPlanPointAlternativeJsonModel, let data = serviceResult.data {
                self.postData(result: data, pagination: pagination)
                return
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        service.connection()
    }
    
}

// MARK: - Google Auto Complete
extension TRPRestKit {
    
    ///  Find
    ///
    /// - Parameters:
    ///   - key: Api key of Google
    ///   - text: Name of place to search.
    ///   - center: Boundary of City.
    ///   - radius: Search radius for limit.
    ///   - completion: Any Object needs to be converted to **[TRPGooglePlace]** object.
    public func googleAutoComplete(key: String,
                                   text: String,
                                   centerForBoundary center: TRPLocation? = nil,
                                   radiusForBoundary radius: Double? = nil,
                                   completion: @escaping CompletionHandler) {
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
        let autoCOmpleteService = TRPGoogleAutoComplete(key: key, text: text)
        autoCOmpleteService.centerLocationForBoundary = center
        autoCOmpleteService.radiusForBoundary = radius
        autoCOmpleteService.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let data = data as? [TRPGooglePlace] {
                self.postData(result: data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
    }
    
}

// MARK: - Google Place
extension TRPRestKit {
    
    /// Returns information of a place from Google Server with place's id.
    /// This method doesn't use Tripian Server.
    ///
    /// - Parameters:
    ///   - key: Google Place Api key
    ///   - id: id of Place that registered in Google
    ///   - completion: Any Object needs to be converted to **TRPGooglePlaceLocation** object.
    public func googlePlace(key: String, id: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        googlePlaceServices(key: key, placeId: id)
    }
    
    /// A services that manage all task to connecting remote server
    private func googlePlaceServices(key: String, placeId: String) {
        let googlePlaceService = TRPGooglePlaceService(key: key, placeId: placeId)
        googlePlaceService.start { (data, error) in
            if let error = error {
                self.postError(error: error)
                return
            }
            
            if let result = data as? TRPGooglePlaceLocation {
                self.postData(result: result)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
    }
    
}

// MARK: - Problem Categories
extension TRPRestKit {
    
    /// Returns categories of problem such as incorrect location, incorrect name etc...
    ///
    /// - Parameter completion: Any Object needs to be converted to **[TRPProblemCategoriesInfoModel]** object.
    public func problemCategories(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        problemCategoriesService()
    }
    
    /// A services that manage all task to connecting remote server
    private func problemCategoriesService() {
        let categoryService = TRPProblemCategories()
        categoryService.completion = { (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPProblemCategoriesJsonModel {
                self.postData(result: serviceResult.datas)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        categoryService.connection()
    }
    
}

// MARK: - Report A problem
extension TRPRestKit {
    
    /// Report a problem about poi.
    ///
    /// - Parameters:
    ///   - id: id of category
    ///   - msg: mesage
    ///   - poi: id of poi
    ///   - completion: Any Object needs to be converted to **TRPReportAProblemInfoModel** object.
    public func reportaProblem(category name: String,
                               message msg: String?,
                               poiId poi: Int?,
                               completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        reportaProblemService(categoryName: name, message: msg, poiId: poi)
    }
    
    /// A services that manage all task to connecting remote server
    private func reportaProblemService(categoryName: String, message: String?, poiId: Int?) {
        let reportAProblemService = TRPReportAProblemServices(categoryName: categoryName,
                                                              message: message,
                                                              poiId: poiId)
        reportAProblemService.completion = { result, error, _ in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPReportAProblemJsonModel {
                self.postData(result: serviceResult.data ?? nil)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        reportAProblemService.connection()
    }
}

// MARK: - Update Daily Plan Hour
extension TRPRestKit {
    
    public func updateDailyPlanHour(dailyPlanId: Int, start: String, end: String, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        updateDailyPlanHourService(dailyPlanId: dailyPlanId, start: start, end: end)
    }
    
    private func updateDailyPlanHourService(dailyPlanId: Int, start: String, end: String) {
        let dailyplanService = TRPDailyPlanServices(id: dailyPlanId, startTime: start, endTime: end)
        dailyplanService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPDayPlanJsonModel {
                self.postData(result: serviceResult.data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        dailyplanService.connection()
    }
    
}
