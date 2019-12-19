//
//  BaseUrlCreaterTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 19.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class BaseUrlCreaterTest: XCTestCase {

    var url = "gogole.com"
    var path = "v2"
    
    func testBaseUrlInitValues() {
        let created = BaseUrlCreater(baseUrl: url, basePath: path)
        XCTAssertEqual(created.baseUrl, url)
        XCTAssertEqual(created.basePath, path)
    }
    
    func testBaseUrlReadable() {
        let created = BaseUrlCreater(baseUrl: url, basePath: path)
        let expectedUrl = "https://\(url)/\(path)"
        XCTAssertEqual(created.reableUrl, expectedUrl)
    }
}
