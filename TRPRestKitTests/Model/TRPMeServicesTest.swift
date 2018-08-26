//
//  TRPMeServicesTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPMeServicesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    func testMe() {
        let expectation = XCTestExpectation(description: "Test Oaut Expectation")
        
        let me = TRPMe(oaut: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImJmYTY5NzJmNTM5ZTIxYmNjN2ExN2UwZWVlZDM3MDFjMDczM2I1ZGJmOGNjYjdjZjQ0NTBiY2FmNmVmZjFkNzA2OWQ4ZjRlOGFlZjUwYzc3In0.eyJhdWQiOiIyIiwianRpIjoiYmZhNjk3MmY1MzllMjFiY2M3YTE3ZTBlZWVkMzcwMWMwNzMzYjVkYmY4Y2NiN2NmNDQ1MGJjYWY2ZWZmMWQ3MDY5ZDhmNGU4YWVmNTBjNzciLCJpYXQiOjE1MzUyODkwNTUsIm5iZiI6MTUzNTI4OTA1NSwiZXhwIjoxNTY2ODI1MDU1LCJzdWIiOiI2Iiwic2NvcGVzIjpbIioiXX0.jFSgBPgb-HL0jD_JU28IdVwA-dC-RqzuzOLrAw9QADaqZua0gwxbsr-hAQ5Ix3Y-bbSo7Ig-VRUpoXwz9_gRnPfQwvQYhoUqUjrWwLuvKlh1JAqOBNZhF1ju2tKmLQ2Z6XcbQ8CA20MjXaQv4oSxFLR9ZueD3OwfTEZAG1GHchGwM_Osfd7qaYYObq-R4h_51jtsPjnnElLfMPosj1vmBlKcOqeoNwK8IeD7c2IWis2H6-tWibdzL37XS2FstD4hAVdjNTkQC0oAb9pA9jnz2hqZaAZVUFfh3dbJluJIASsHf5ju4lKjYWYeOfetM1HrFo-4RK5jo5Nib15qXFx5lZzagQ7bi_5c-O7HqFLdWxfbLiSumBUHRya29PNfHC2R3fimkp5mShLGNBbhyv6wzTx3dV_y2PwY3gmm2kVzdQ1VibJZskZ5mvBcxXuwy5Huwlu5RNpO0rjdou2HBkBdVEWERakJa3eIZjHTz2gYeeMUG3sUZPlwkgDeuVAC3AYNxv_4RPKdiWgl6W2C3saY4I1EwaNNWngUEF51OVkLSelzeK1AJTA3jAj4l_w4E8BDhra0wBPAC6-ye7_RBsIvU84GSOarFuQmGSYkVepqzCBmRHOS0Et1P05liqk9wFsY1-jW7GO4pUF__7S4bnMaak4SWdGup8v95uk9Wrj05bg")
        me.Completion = {(result, error, pagination) in
            if let error = error {
                XCTFail("User Me Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("User Me Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPUserMeJsonModel else {
                XCTFail("User Me Json model coundn't converted to  TRPUserMeJsonModel")
                return
            }
            
            print("User Name : \(jsonModel.data.firstName)")
            expectation.fulfill()
        }
        me.connection()
        
        wait(for: [expectation], timeout: 15.0)
    }
}
