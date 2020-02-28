//
//  TRPImageParserTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 28.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPImageParserTest: XCTestCase {
    
    let rawImageWithoutImageOwner = """
        {
            "url": "https://poi-pics.s3-eu-west-1.amazonaws.com/City/228/featured.jpg",
            "image_owner": null
        }
    """
    
    func testCityArrayParser() {
        do {
            
            let result  = try JSONDecoder().decode(TRPImageModel.self, from: rawImageWithoutImageOwner.data(using: String.Encoding.utf8)!)
            //XCTAssertEqual(result.data!.count, 1)
            //XCTAssertEqual(result.data!.first!.id, 1)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    
    //TODO: - FULL DATA EKLENECEK
}
