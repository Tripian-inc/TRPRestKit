//
//  TRPUserTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 26.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPUserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    func testCreateUser() {
        return
        let expectation = XCTestExpectation(description: "USER Expectation")
      
        let user = TRPUser(firstName: "Evren", lastName: "Yaşar", email: "necatievren@gmail.com", password: "123456")
        user.Completion = {(result, error, pagination) in
            if let error = error {
                XCTFail("User Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("User Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPUserMeJsonModel else {
                XCTFail("User Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
            print(jsonModel.data.firstName)
            expectation.fulfill()
            
        }
        
        user.connection()
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    
    
    func  testRename() {
        let oauth = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImFkNmZjYzI2MzA4MWI1MDIyNTk5YzdjMzFhNWMzMjdjNzEwYTQ0NmQ2OTg1MjkyMmE5NjY1ZjIwZWFiZGQ4ZjY5ODI5ZjdjM2ViMjVhMGZjIn0.eyJhdWQiOiIyIiwianRpIjoiYWQ2ZmNjMjYzMDgxYjUwMjI1OTljN2MzMWE1YzMyN2M3MTBhNDQ2ZDY5ODUyOTIyYTk2NjVmMjBlYWJkZDhmNjk4MjlmN2MzZWIyNWEwZmMiLCJpYXQiOjE1MzUyOTAyNTcsIm5iZiI6MTUzNTI5MDI1NywiZXhwIjoxNTY2ODI2MjU3LCJzdWIiOiI2Iiwic2NvcGVzIjpbIioiXX0.Cr7DHmrvY8ze68HIf7qmwj_HjdMIhpsEFRg2GvFw54MgJkCy8k3ghRsKTB9d4n4EIkOJIz6fqKyO0fcrno6wzXzh3OemPgOQ84cOKbFF_oDnJfbmJ4zj3y0NIGhcLWCHe_UVhOqc7Zkpo686XZmrRYt-sPGv7VBwlxUzk0yEIxb25BDxBQ3DPdVFqWtn1ExI72352gh4RkUO1UPtgYIXIijKOppNFtg0De1kDH_BMwsl7Kp6Zlktaq92-MXJAtl5KtunkZTIVBwG15A75vxFYBhWxJt0T9Aro6fAsg45JnJY6h9vZVAjhXvpN5x_qc-itv0mSrXuUvK_6s-WZS88whjA3chtsZxLbcWdYx46fHNr5FQJu6SZuBf3ip1tr435ObqcyE8hnCHGLecOQ4sLoQ9zdJgT6d3VCd5ogDRdIkVpDhxpnSIhyJuREBTgbvODVUkAvbTYdrgqA5zVxYsQBDZryT40QffACi-Pxd1wR4gp5R3St44pTbSzC2c1A16faFuMVZLBpJ_N2UzbOsfjEP458o_ZXT0eZNTjWoFdDz5u51M-9lc0V6ZY1aOj9NhFpzMaoR2iio-f6tQPImmtEaBOd245bHzNKm98kdFK7rBoMYDCd8uwP3Nuv1Ki9IYpeT5IzvHjZMpgMtFyLTZG5tG9YjLLHjheFJTeyXcJ1PI"
        
        let expectation = XCTestExpectation(description: "USER Expectation")
        let user = TRPUser(oauth: oauth, id: 6, firstName: "Necati Evren 34", lastName: "Yasar", password: "123456")
        user.Completion = {(result, error, pagination) in
            if let error = error {
                XCTFail("User Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("User Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPUserMeJsonModel else {
                XCTFail("User Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
            print(jsonModel.data.firstName)
            expectation.fulfill()
            
        }
        
        user.connection()
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    
    
    func testRemoveUser() {
        let oauth = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImJmYTY5NzJmNTM5ZTIxYmNjN2ExN2UwZWVlZDM3MDFjMDczM2I1ZGJmOGNjYjdjZjQ0NTBiY2FmNmVmZjFkNzA2OWQ4ZjRlOGFlZjUwYzc3In0.eyJhdWQiOiIyIiwianRpIjoiYmZhNjk3MmY1MzllMjFiY2M3YTE3ZTBlZWVkMzcwMWMwNzMzYjVkYmY4Y2NiN2NmNDQ1MGJjYWY2ZWZmMWQ3MDY5ZDhmNGU4YWVmNTBjNzciLCJpYXQiOjE1MzUyODkwNTUsIm5iZiI6MTUzNTI4OTA1NSwiZXhwIjoxNTY2ODI1MDU1LCJzdWIiOiI2Iiwic2NvcGVzIjpbIioiXX0.jFSgBPgb-HL0jD_JU28IdVwA-dC-RqzuzOLrAw9QADaqZua0gwxbsr-hAQ5Ix3Y-bbSo7Ig-VRUpoXwz9_gRnPfQwvQYhoUqUjrWwLuvKlh1JAqOBNZhF1ju2tKmLQ2Z6XcbQ8CA20MjXaQv4oSxFLR9ZueD3OwfTEZAG1GHchGwM_Osfd7qaYYObq-R4h_51jtsPjnnElLfMPosj1vmBlKcOqeoNwK8IeD7c2IWis2H6-tWibdzL37XS2FstD4hAVdjNTkQC0oAb9pA9jnz2hqZaAZVUFfh3dbJluJIASsHf5ju4lKjYWYeOfetM1HrFo-4RK5jo5Nib15qXFx5lZzagQ7bi_5c-O7HqFLdWxfbLiSumBUHRya29PNfHC2R3fimkp5mShLGNBbhyv6wzTx3dV_y2PwY3gmm2kVzdQ1VibJZskZ5mvBcxXuwy5Huwlu5RNpO0rjdou2HBkBdVEWERakJa3eIZjHTz2gYeeMUG3sUZPlwkgDeuVAC3AYNxv_4RPKdiWgl6W2C3saY4I1EwaNNWngUEF51OVkLSelzeK1AJTA3jAj4l_w4E8BDhra0wBPAC6-ye7_RBsIvU84GSOarFuQmGSYkVepqzCBmRHOS0Et1P05liqk9wFsY1-jW7GO4pUF__7S4bnMaak4SWdGup8v95uk9Wrj05bg"
        
        let expectation = XCTestExpectation(description: "USER Expectation")
        let user = TRPUser(oauth: oauth, id: 6)
        
        //let user = TRPUser(oauth: oauth, id: 6, firstName: "Necati Evren 34", lastName: "Yasar", password: "123456")
        user.Completion = {(result, error, pagination) in
            if let error = error {
                XCTFail("User Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("User Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPUserMeJsonModel else {
                XCTFail("User Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
            print(jsonModel.data.firstName)
            expectation.fulfill()
            
        }
        
        user.connection()
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    
    
    
    
    
    
}
