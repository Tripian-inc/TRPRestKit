//
//  TRPRestKitTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPRestKitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    
    func testCities()  {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.cities expectation")
        
        TRPRestKit().cities { (result, error) in
            if let error = error {
                XCTFail("City Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("City Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPCityJsonModel else {
                XCTFail("City Json model coundn't converted to  TRPCityJsonModel")
                return
            }
            
            guard let citiesInfoModel = jsonModel.data else {
                XCTFail("City Json model have got no info models")
                return
            }
            
            XCTAssert(citiesInfoModel.count > 0, "Haven't got cities model")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testPlacesTypes() {
        let expectation = XCTestExpectation(description: "TRPRestKit.Types expectation")
        
        TRPRestKit().placeTypes { (result, error) in
            if let error = error {
                XCTFail("Types Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Types Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPPlaceTypeJsonModel else {
                XCTFail("Types Json model coundn't converted to  TRPPlaceTypeJsonModel")
                return
            }
            
            guard let citiesInfoModel = jsonModel.data else {
                XCTFail("Types Json model have got no info models")
                return
            }
            
            XCTAssert(citiesInfoModel.count > 0, "Haven't got Types model")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTypes() {
        let expectation = XCTestExpectation(description: "TRPRestKit.Types expectation")
        
        TRPRestKit().placeTypes { (result, error) in
            if let error = error {
                XCTFail("Types Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Types Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPPlaceTypeJsonModel else {
                XCTFail("Types Json model coundn't converted to  TRPPlaceTypeJsonModel")
                return
            }
            
            guard let citiesInfoModel = jsonModel.data else {
                XCTFail("Types Json model have got no info models")
                return
            }
            
            XCTAssert(citiesInfoModel.count > 0, "Haven't got Types model")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testOnePlace() {
        let expectation = XCTestExpectation(description: "TRPRestKit.Places expectation")
        TRPRestKit().place(withId: 2365) { (result, error) in
            if let error = error {
                XCTFail("Places Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Places Resutl is nil")
                return
            }
            guard let jsonModel = result as? TRPPlaceJsonModel else {
                XCTFail("Places Json model coundn't converted to  TRPPlaceJsonModel")
                return
            }
            guard let infoModel = jsonModel.data else {
                XCTFail("Places Json model have got no info models")
                return
            }
            
            XCTAssert(infoModel.count > 0, "Haven't got Places model")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testQuestionForIstanbul() {
        let expectation = XCTestExpectation(description: "TRPRestKit.Question expectation")
        
        TRPRestKit().question(cityId: 107) { (result, error) in
            if let error = error {
                XCTFail("Question Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Question Resutl is nil")
                return
            }
            guard let jsonModel = result as? TRPQuestionJsonModel else {
                XCTFail("Question Json model coundn't converted to  TRPCityJsonModel")
                return
            }
            guard let infoModel = jsonModel.data else {
                XCTFail("Places Json model have got no info models")
                return
            }
            
            XCTAssert(infoModel.count > 0, "Haven't got Places model")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRecommendationForIstanbul() {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.Recommendation expectation")
        
        let rec = TRPRecommendationSettings(cityId: 107)
        TRPRestKit().recommendation(settings: rec) { (result, error) in
            if let error = error {
                XCTFail("Recommendation Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Recommendation Resutl is nil")
                return
            }
            guard let jsonModel = result as? TRPRecommendationJsonModel else {
                XCTFail("Recommendation Json model coundn't converted to  TRPCityJsonModel")
                return
            }
            guard let infoModel = jsonModel.data else {
                XCTFail("Recommendation Json model have got no info models")
                return
            }
            
            XCTAssert(infoModel.count > 0, "Haven't got Recommendation model")
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testLogin() {
        let expectation = XCTestExpectation(description: "TRPRestKit.userLogin expectation")
        let mail = "necatievren@gmail.com"//"test@tripian.com"
        let password = "123456"
        TRPRestKit().userLogin(email: mail, password: password) { (result, error) in
            if let error = error {
                XCTFail("UserLogin Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("UserLogin Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPOAuthJsonModel else {
                XCTFail("UserLogin Json model coundn't converted to  TRPOAuthJsonModel")
                return
            }
            
            guard let userHash = TRPUserPersistent.fetchHash() else{
                XCTFail("UserLogin Hash coundn't save")
                return
            }
            
            XCTAssertEqual(userHash, jsonModel.data.accessToken,"User hash not equel user token")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testMyProgram() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getMyProram expectation")
        
        TRPRestKit().getMyProgram { (result, error, pagination) in
            if let error = error {
                XCTFail("MyProgram Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("MyProgram Resutl is nil")
                return
            }
            
            guard let _ = result as? TRPMyProgramsJsonModel else {
                XCTFail("MyProgram Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
           expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testGetProgram() {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "GetProgram"
        let programHash = "cd774e23e78a7a90db276dfaebbefbe1" // 8218494776115390d31b85aefc7c2ac5
        TRPRestKit().getProgram(withHash: programHash) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            
            guard let _ = result as? TRPProgramJsonModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testCreateProgram() {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "CreateProgram"
        let arrival = TRPTime(year: 2019, month: 01, day: 05, hours: 08, min: 00)
        let departure = TRPTime(year: 2019, month: 01, day: 08, hours: 18, min: 00)
        let settings = TRPProgramSettings(cityId: 107, arrivalTime: arrival, departureTime: departure)
        
        TRPRestKit().createProgram(settings: settings) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPProgramJsonModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testAddNewDay() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "AddNewDay"
        
        TRPRestKit().addNewProgramDayIn(hash: "8218494776115390d31b85aefc7c2ac5", position: TRPProgramDayPosition.end) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPProgramDayJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetProgramDetail() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "AddNewDay"
        TRPRestKit().getProgramDay(dayId: 64) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPProgramDayJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testNearByAll() {
        let programHash = "cd774e23e78a7a90db276dfaebbefbe1"
        let expectation = XCTestExpectation(description: "TRPRestKit.nearByAll expectation")
        let nameSpace = "NearByAll"
        
        TRPRestKit().nearByAll(withHash: programHash) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPNearByJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNearProgramStep() {
        let stepId = 269
        let expectation = XCTestExpectation(description: "TRPRestKit.nearBy expectation")
        let nameSpace = "NearBy"
        
        TRPRestKit().nearBy(withProgramStepId: stepId) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPNearByJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testGetPreferences() {
        let expectation = XCTestExpectation(description: "TRPRestKit.nearBy expectation")
        let nameSpace = "Get Preferences"
        
        TRPRestKit().getPreferences { (result, error, _)  in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPPreferenceJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAddPreferences() {
        let expectation = XCTestExpectation(description: "TRPRestKit.nearBy expectation")
        let nameSpace = "Get Preferences"
        
         TRPRestKit().addPreferences(key: "InfoKey", value: "123123") { (result, error, _)  in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPPreferenceJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetProgramStepInfo() {
        let expectation = XCTestExpectation(description: "TRPRestKit.nearBy expectation")
        let nameSpace = "Get Program Step Info"
        TRPRestKit().getProgramStep(id: 269) { (result, error)  in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPProgramStepJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAddProgramStep() {
        let expectation = XCTestExpectation(description: "TRPRestKit.nearBy expectation")
        let nameSpace = "Add Program Step Info"
        let hash = "cd774e23e78a7a90db276dfaebbefbe1"
        TRPRestKit().addProgramStep(hash: hash, dayId: 1, placeId: 200, order: 1)  { (result, error)  in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPProgramStepJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateProgramStep() {
        let expectation = XCTestExpectation(description: "TRPRestKit.update expectation")
        let nameSpace = "Update Program Step Info"
        
        //TRPRestKit().updateProgramStep(id: 266, completion: <#T##TRPRestKit.CompletionHandler##TRPRestKit.CompletionHandler##(Any?, NSError?) -> Void#>)
//        TRPRestKit().addProgramStep(hash: hash, dayId: 1, placeId: 200, order: 1)  { (result, error)  in
//            if let error = error {
//                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
//                return
//            }
//            guard let result = result else {
//                XCTFail("\(nameSpace) Resutl is nil")
//                return
//            }
//            guard let _ = result as? TRPProgramStepJsonModel  else {
//                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
//                return
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testDeleteProgramStep() {
        let expectation = XCTestExpectation(description: "TRPRestKit.update expectation")
        let nameSpace = "Update Program Step Info"
        
        TRPRestKit().deleteProgramStep(id: 270) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPProgramStepJsonModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            expectation.fulfill()
        }
         wait(for: [expectation], timeout: 10.0)
       
    }
    
}


