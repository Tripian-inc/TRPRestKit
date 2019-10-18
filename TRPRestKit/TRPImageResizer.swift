//
//  TRPImageResizer.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 30.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Provides new link to resizing Images
public class TRPImageResizer {
    
    public init(){}
    
    
    /// New link of image generater
    ///
    /// - Parameters:
    ///   - link: Image source link
    ///   - w: target width
    ///   - h: target height
    /// - Returns: new link 
    public static func generate(imageLink link: String, width:Int, height:Int) -> String? {
        if let component = URLComponents(string: link) {
            let link = "https://d1drj6u6cu0e3j.cloudfront.net/\(width)x\(height)/smart\(component.path)"
            return link
        }
        return nil
    }
}
