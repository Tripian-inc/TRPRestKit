# Tripian Rest Kit

Tripian Rest Kit makes it easy to connect your iOS application to the Tripian APIs. It provides you all the tools you need to create personalized recommendations and itineraries for your customers. 

The Tripian Rest Kit is powered by the Tripian Rest API and Tripian recommendation engines. For more information, see the [Tripian Recommendation API Page](https://tripian-inc.github.io/APIV3-Released/api-spec.html).

Tripian Rest Kit pairs well with Tripian Core Kit SDK for iOS.

Tripian Rest Kit framework is written in Swift.

The key features are:
- [Features](#features)
- [Documentation](#documentation)
- [Component Frameworks](#component-frameworks)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Use Cases](#use-cases)
- [Examples](#examples)
- [Communication](#communication)
- [License](#license)

## Features

* Cities
  * Tripian features over 250 cities world-wide. Each city has a unique id (cityId) that you will need to use in creating trips, trip related questions and getting quick recommendations.
* Places of Interest
  * To reach over 1M places of interests, call TRPRestKit().poi(..) functions.
* User Management
  * Login, Obtain personal user information, Updating user information , Obtaining user payment history, User’s past and upcoming trips, User's all favorite place of interests list, User's companions, Password reset requests,  etc. 
* Trip Planner
  * Getting trip questions, Creating a personolized trip, Obtaining trip info, Getting daily plan info, Adding place of interests into daily plans, etc.
* Quick Recommendations
  * Getting quick recommendation with a given cityId or trip hash.
* Comprehensive Unit and Integration Test Coverage.
* English and French Language Support.

## Documentation

See the [TRPRestKit documentation](http://airmiles-api-1837638174.ca-central-1.elb.amazonaws.com/apidocs/#tripian-recommendation-engine) for usage examples.

## Component Frameworks

In order to keep Tripian Rest kit focused specifically on networking implementations of Tripian Rest API, additional component frameworks have been created by the [Tripian Software Team](https://www.tripian.com/about-us/) to bring additional functionality to the Tripian IOS Frameworks ecosystem.

- **TRPCoreKit** - A Core framework which includes all the operations of Tripian Rest Kit in view controllers including with core functionalities. Such as creating trip, getting daily plan list, performing user management, viewing or editing user's upcoming & past trips, etc.

- **TRPFoundationKit** - A Foundation framework which defines a base layer of functionality among Tripian IOS Frameworks. It provides primitive classes and introduces several paradigms that makes developing with TRPRestKit more easier by introducing consistent conventions.

## Requirements

Tripian Rest Kit and Tripian Core Kit are compatible with applications written in Swift 5 in Xcode 10.2 and above. Tripian Rest Kit and Tripian Core Kit frameworks run on iOS 11.0 and above.


## Installation

### Using CocoaPods

To install TRP Rest Kit using [CocoaPods](https://cocoapods.org/):

1. Create a [Podfile](https://guides.cocoapods.org/syntax/podfile.html) with the following specification:
   ```ruby
   pod 'TRPRestKit', :git => 'https://github.com/tripian/trRestKit.git'
   ```
   The platform specified in your Podfile should be `:iOS '11'`

1. Run `pod repo update && pod install` and open the resulting Xcode workspace.

1. In `Info.plist`, add `TripianAccessToken` with your [Tripian Access Token](https://www.tripian.com/request-api-key/) as the value.

## Usage

**Tripian APIs require a Tripian account and API access token.** In the project editor, select the application target, then go to the Info tab. Under the “Custom iOS Target Properties” section, set `TripianAccessToken` to your access token. You can obtain an access token from the [Tripian Recommendation API Page](https://tripian-inc.github.io/APIV3-Released/dev/api-spec.html).

**Adding internet permission:** The TRPRestKit SDK requires internet permission to work properly. Under the “NSAppTransportSecurity” section, set `NSAllowsArbitraryLoads` to `NO`. 


##### Now import the TRPRestKit module.

```swift
import TRPRestKit
```
##### Always call TRPRestKit() instance to reach Tripian Rest Api calls. 
TRPRestKit() is an NSObject instance which monitors all the Tripian Rest Api calls.

<details>
<summary>Getting Cities</summary>

+ Call `cities` function to get all the cities.

```swift
TRPRestKit().cities {(result, error, pagination) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? [TRPCityInfoModel]  else {
        //TODO: Check the result.
        return
    }
}
```
</details>

<details>
<summary>Trip Planner</summary>

+ ### Creating Trip 
#### Create trip by calling create trip function, with a TRPTripSettings instance parameter.

```swift
//Create TrpTripSettings instance with cityId,arrivalTime and departureTime.
let cityId: Int = 0 //cityId refers to an integer value as an id of the city where trip will be generated.
let arrivalTime: TRPTime = getToday()//arrivalTime parameter refers to a TRPTime instance to specify arrival time of the trip.
let departureTime: TRPTime = getTomorrow()//departureTime parameter refers to a TRPTime instance to specify departure time of the trip.
let tripSettings = TRPTripSettings(cityId: cityId, arrivalTime: arrivalTime, departureTime: departureTime)
         
//Call create trip function with the tripSettings param.
TRPRestKit().createTrip(settings: settings) {(result, error) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }     
    guard let result = result as? TRPTripInfoModel else {
        //TODO: Check the result.
        return
    }
}
```

+ ### Getting Trip 
#### To reach trip object, call get trip function by adding the given trip hash.

```swift
// Get Trip with a given trip hash.
TRPRestKit().getTrip(withHash: hash) {(result, error) in
     if let error = error {
         //TODO: Check whether there is an error.
         return
     }
     if let result = result as? TRPTripInfoModel {
         //TODO: Check the result.
         return
     }
}
```

+ ### Editing Trip
#### Edit trip by adding TRPTripSettings instance and provide given trip hash.

```swift
//Edit trip with a given editedTripSettings including with selected trip hash.
let editedTripHash = ""
let editedArrivalTime: TRPTime = getToday()
let editedDepartureTime: TRPTime = getTomorrow()
let editedTripSettings = TRPTripSettings(hash: editedTripHash, arrivalTime: editedArrivalTime, departureTime: editedDepartureTime)
//Call edit trip function with the created editedTripSettings variable including with the selected trip hash.
TRPRestKit().editTrip(settings: editedTripSettings) {(result, error) in    
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }  
    guard let result = result as? TRPTripInfoModel else {
        //TODO: Check the result.
        return
    }
}
```

+ ### Deleting Trip
#### To delete a trip, call delete trip function with a trip hash.

```swift
//Delete trip with a given trip hash.
let tripHash = ""
TRPRestKit().deleteTrip(hash: tripHash) {(result, error) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? TRPParentJsonModel else {
        //TODO: Check the result.
        return
    }
}
```
</details>

<details>
<summary>Places of Interest</summary>

+ To reach over 1M places of interests, call `TRPRestKit().poi(..)` functions.

```swift
let cityId:Int = 0 //To define city location, cityId parameter must be used in calling places of interests.
let autoPagination:Bool = false //Autopagination param refers to disable auto pagination during the call.
TRPRestKit().poi(withCityId: cityId, autoPagination: autoPagination) {(result, error, pagination) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? [TRPPoiInfoModel]  else {
        //TODO: Check the result.
        return
    }
}
```
</details>

<details>
<summary>Daily Plans</summary>

+ ### Getting Daily Plan
#### Obtain daily plan information.
```swift
let dailyPlanId:Int = 0 // dailyPlanId variable refers to the requested daily plan id.
TRPRestKit().dailyPlan(id: dailyPlanId) {(result, error) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = dailyPlan as? TRPDailyPlanInfoModel else {
        //TODO: Check the result.
        return
    }
}
```

+ ### Updating Daily Plan
#### Only start and end times of day plan can be updated. Day plan will be regenerated after update.
```swift
//Below function updates daily plan starting and ending hours with given dailyPlanId, start and end times.
let dailyPlanId:Int = 0 //dailyPlanId variable refers to the requested daily plan id.
let startTime:String = "10:00" //startTime variable refers to daily plan's start time.
let endTime:String = "21:00" //endTime variable refers to daily plan's end time.
        
//Update daily plan with requested times.
TRPRestKit().updateDailyPlanHour(dailyPlanId: dailyPlanId, start: startTime, end: endTime) {(dailyPlan, error) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = dailyPlan as? TRPDailyPlanInfoModel else {
        //TODO: Check the result.
        return
    }
}
```

+ ### Changing Daily Plan
#### Updating daily plan place of interest with the requested place.

```swift
//Changing daily plan place of interest with the requested place.
let oldDailyPlanID:Int = 0 //oldDailyPlanID variable refers to the place which will be replaced soon.
let newDailyPlanPoiID:Int = 1 //newDailyPlanPoiID variable refers to the requested place.
//oldDailyPlanID will be replaced by newDailyPlanPoiID.
TRPRestKit().replacePlanPoiFrom(dailyPlanPoiId: oldDailyPlanID, poiId: newDailyPlanPoiID) {(result, error) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? TRPPlanPoi else {
        //TODO: Check the result.
        return
    }
}
```
</details>
<details>
<summary>User Management</summary>

+ ### User Login
#### Obtain access for restkit functions that require user identification. 

```swift
let email:String = "someEmail@example.com"
let password:String = "somepassword"
TRPRestKit().login(email: email, password: password) {(result, error) in
    if error != nil {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? TRPLoginInfoModel  else {
        //TODO: Check the result.
        return
    }
}
```

+ ### User Info
#### Obtain logged in user information.

```swift
TRPRestKit().userInfo {(result, error) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? TRPUserInfoModel  else {
        //TODO: Check the result.
        return
    }
}
```
</details>

<details>
<summary>Quick Recommendations</summary>

+ Getting quick recommendation with a given `TRPRecommendationSettings` instance.

```swift
//Recommendation function used among trip operations.
let cityId:Int = 0 //To define city location, cityId parameter must be used in getting recommendations.
let recommendationSetting:TRPRecommendationSettings = TRPRecommendationSettings(cityId: cityId)//recommendationSetting variable refers to an TRPRecommendationSettings instance.
        
//Call quickRecommendation function with the created recommendationSetting variable.
TRPRestKit().quickRecommendation(settings: settings) { (result, error, pagination) in
    if let error = error {
        //TODO: Check whether there is an error.
        return
    }
    guard let result = result as? [TRPRecommendationInfoJsonModel]  else {
        //TODO: Check the result.
        return
    }
}
```
</details>

Consult the [Api Documentation](https://tripian-inc.github.io/APIV3-Released/dev/api-spec.html),[Unit and Integration Tests](https://tripian-inc.github.io/APIV3-Released/dev/api-spec.html) for further details.

## Use Cases

### Creating Trip
<p align="center">
  <img src="https://github.com/Tripian-inc/TRPRestKit/blob/master/CreateTrip.png" height="300" alt="Creating Trip">
</p>

### Trip Info
<p align="center">
<img src="https://github.com/Tripian-inc/TRPRestKit/blob/master/OpenTrip.png" height="300" alt="Trip Info">
</p>

### Understanding Daily Plans
<p align="center">
<img src="https://github.com/Tripian-inc/TRPRestKit/blob/master/Undestand%20DailyPlans.png" height="300" alt="Daily Plans">
</p>

## Examples

The [TRPRestKit-IOS-Examples](https://github/trprestkitiosexamples) includes example code for accomplishing common tasks that exercises a variety of Tripian Rest Kit SDK features:

1. Clone the repository or download the [.zip file](https://github.com/tripian/trprestkit-ios/archive/master.zip)
1. Run `pod repo update && pod install` and open the resulting Xcode workspace.
1. Open `TrpRestKitIOSExample.xcodeproj`.
1. Sign up or log in to your Tripian account and grab a [Tripian Access Token](https://www.tripian.com/request-api-key/).
1. Open the Info.plist in the `Example` target and paste your [Tripian Access Token](https://www.tripian.com/request-api-key/) into `TripianAccessToken`. (Alternatively, you can set the access token while calling the `TrpRestKit(withAccessToken: AccessToken)` instead of adding it to Info.plist.)
1. Build and run the `Example` target.

- TrpRestKitiOS.Tests includes comprehensive Unit and Integration Tests of Tripian Rest Kit SDK features.

## Communication
- If you **need help with TRPRest Kit**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/trprestkit) and tag `trprestkit`.
- If you need to **find or understand the Tripian Recommendation Engine API**, check [our documentation](https://tripian-inc.github.io/APIV3-Released/dev/api-spec.html).
- If you **found a bug**, open an issue here on GitHub and follow the guide. The more detail the better!

## Built With
* **TRPFoundationKit** - framework is created by the [Tripian Software Team](https://www.tripian.com/about-us/) to provide primitive classes and introduce several paradigms that makes developing with TRPRestKit more easier by introducing consistent conventions.

