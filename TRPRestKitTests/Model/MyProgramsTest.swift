//
//  MyProgramsTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class MyProgramsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    func testMyProgram() {
        let expectation = XCTestExpectation(description: "Test Oaut Expectation")
        let oaut = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ0M2ZlOWIwMDMyNmEzZjc2OTBjMmUxMGFiOWVhMTc3YTkxZDYzOGNiMGJlMzViNmVhZTQzYjdhMmNhYzhlZDk4NjVkNWYzMjQzODczMDRhIn0.eyJhdWQiOiIyIiwianRpIjoiZDQzZmU5YjAwMzI2YTNmNzY5MGMyZTEwYWI5ZWExNzdhOTFkNjM4Y2IwYmUzNWI2ZWFlNDNiN2EyY2FjOGVkOTg2NWQ1ZjMyNDM4NzMwNGEiLCJpYXQiOjE1MzUxOTk2MDAsIm5iZiI6MTUzNTE5OTYwMCwiZXhwIjoxNTY2NzM1NjAwLCJzdWIiOiIxIiwic2NvcGVzIjpbIioiXX0.Abs1NWmRaKvzOoyq8YgSwMtebr9Kv714gKW8IrU-6qdvjDnp-Docf8EcAuSuV3pjZym5aBE5o4WShn9qbc7tJRGkMjUafwUWQyb4aH851ZTfMUmULUY63UO7x7S43_nbKN1iTK_9stcrWcJYuuCvFbvDsoBw_2gXxYB-D9D46rUZl2ho0C2qZcNkwXbXOz2q0XhsbIGCTSM7v_gTSx5gFMHJtEovwPH9eaLzJ_M3h8ZAZIM9Fzkf_4_xOwYwusoZX7UJmyDhS7hzdxz1Zt8ZX5llOFL9xzIAa_eLgOTO-RnAweVwSBgvblJTcKWkFkjhsUt6dqVji3wu7B4Q12FhQf0_1rTBhXOt3dUKuQx_lJgWLsT-5725eAaaZYh8ScK_vSaR_6Ry2vQezg1ooT_CCSFGblbUnhDfTokofGbSsFwhBMWznf65wPMz0po9G1TjKH7r5BUWcXmeCXieYWOKHkh08_oZs4LRdbNW8a-ZnhAdzh5qeb2GQQFnqM4MrZvbqClknD4VFC10d7kAYU9bktPV5pM4OO7XoPr207FagdPXU7TPC50dKvVl-XnMH0zBEg-xQup_fO5nffq5KohHmW6W4cWW5AXfxzBQU0ZqJ8yXQBO1-VtrU53dPGdaN_sSkiNQp6xa8ryT2NqsUfS8vV2Kaz5TT0NV_IxsMANmPwM"
        let myProgram = TRPMyProgram(oaut: oaut)
        
        myProgram.Completion = {(result, error, pagination) in
            if let error = error {
                XCTFail("My Program Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("My Program Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPMyProgramsJsonModel else {
                XCTFail("My Program Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
            guard let programs = jsonModel.data else {
                XCTFail("My Program Json model no have a program")
                return
            }
            expectation.fulfill()
            
        }
        
        myProgram.connection()
        
        wait(for: [expectation], timeout: 15.0)
    }
}
