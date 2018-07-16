//
//  TRPBundleController.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 6.06.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPBundleController : NSObject{
    
    public func getTextFromBundle() -> String? {
        
        guard let bundlePath = Bundle.main.path(forResource: "TRPBundle", ofType: "bundle") else {
            print("Bundle file's path didnt found in framework");
            return nil
        }
        
        guard let externalBundle = Bundle(path: bundlePath) else {print("Bundle didn't create");return nil}
        
        if let textPath = externalBundle.path(forResource: "test2", ofType: "txt") {
            do {
                let content = try String(contentsOfFile: textPath);
                return content;
            }catch let error {
                print("Content didn't readed. Error: \(error.localizedDescription)");
            }
        }else {
            print("Text2 file didn't find");
        }
        
        return nil
    }
    
    public func getTextFromBundleWithClass() -> String? {
        guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "TRPBundle", ofType: "bundle") else {
            print("Bundle file's path didnt found in framework");
            return nil
        }
        
        guard let externalBundle = Bundle(path: bundlePath) else {print("Bundle didn't create");return nil}
        
        if let textPath = externalBundle.path(forResource: "test2", ofType: "txt") {
            do {
                let content = try String(contentsOfFile: textPath);
                return content;
            }catch let error {
                print("Content didn't readed. Error: \(error.localizedDescription)");
            }
        }else {
            print("Text2 file didn't find");
        }
        
        return nil
    }
    
}
