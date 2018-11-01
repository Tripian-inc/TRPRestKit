//
//  TRPImageResizer.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 30.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPImageResizer {
    public init(){}
    public static func generate(imageLink link: String, w:Int, h:Int) -> String? {
        if let component = URLComponents(string: link) {
            return "https://d1drj6u6cu0e3j.cloudfront.net/\(w)x\(h)/smart\(component.path)"
        }
        return nil
    }
}
