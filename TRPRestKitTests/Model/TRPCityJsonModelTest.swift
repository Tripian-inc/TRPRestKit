//
//  TRPCityJsonModelTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPCityJsonModelTest: XCTestCase {
    
    var jsonDecoder: JSONDecoder?
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
        jsonDecoder = JSONDecoder()
    }
    
    func testBaseData() {
        let rawJson = """
        {
            "status": 200,
            "success": true,
            "data": [
                    {
                        "id": 44,
                        "city_name": "Berlin",
                        "coord": {
                            "lat": 52.5200066,
                            "lng": 13.404953999999975
                        }
                    }
            ]
        }
"""

        do {
            let result = try jsonDecoder!.decode(TRPCityJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            
            if result.data == nil {
                XCTFail("TRPCity models is nil")
            }
            
            guard let berlin = result.data?.first else {
                XCTFail("TRPCity first data is nil")
                return
            }
            
            XCTAssertEqual(berlin.id, 44,"Berlin's id not equeal 44")
            XCTAssertEqual(berlin.name, "Berlin","Berlin's name not equeal Berlin")
            XCTAssertEqual(berlin.coordinate.lat, 52.5200066,"Berlin's lat not equeal 52.5200066")
            XCTAssertEqual(berlin.coordinate.lon, 13.404953999999975,"Berlin's lon not equeal 13.404953999999975")
            
        }catch(let tryError) {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    
    func testFullCityData() {
        let rawJson = """
        {
            "status": 200,
            "success": true,
            "data": [
                    {
                        "id": 44,
                        "city_name": "Berlin",
                        "img": "https://www.tripian.com/planner/Uploads/Media/2017/Cities/berlin.jpg",
                        "coord": {
                            "lat": 52.5200066,
                            "lng": 13.404953999999975
                        },
                        "position": 0,
                        "country": {
                            "code": "deu",
                            "name": "Germany",
                            "continent": {
                                "name": "Europe"
                            }
                        }
                    }
            ]
        }
"""
        
        do {
            let result = try jsonDecoder!.decode(TRPCityJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            
            if result.data == nil {
                XCTFail("TRPCity models is nil")
            }
            
            guard let berlin = result.data?.first else {
                XCTFail("TRPCity first data is nil")
                return
            }
            
            XCTAssertEqual(berlin.id, 44,"Berlin's id not equeal 44")
            XCTAssertEqual(berlin.name, "Berlin","Berlin's name not equeal Berlin")
            XCTAssertEqual(berlin.coordinate.lat, 52.5200066,"Berlin's lat not equeal 52.5200066")
            XCTAssertEqual(berlin.coordinate.lon, 13.404953999999975,"Berlin's lon not equeal 13.404953999999975")
            guard let country = berlin.country else {
                XCTFail("Country data is nil")
                return
            }
            XCTAssertEqual(country.code, "deu","Berlin's deu not equeal")
            XCTAssertEqual(country.name, "Germany","Berlin's deu not equeal")
            guard let continent = berlin.country?.continient else {
                XCTFail("Continient data is nil")
                return
            }
            XCTAssertEqual(continent, "Europe","Berlin's Continent name not equeal")
            
        }catch(let tryError) {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    
    func testConnection() {
        let expectation = XCTestExpectation(description: "City Network Expectation")
        TRPRestKit().cities { (result, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
   
}
