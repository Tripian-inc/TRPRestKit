//
//  TRPImageResizer.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 30.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

public enum TRPImageSizeStandart {
    case small, placeDetail, myTrip
    
    public var size: (width: Int, height: Int) {
        switch self {
        case .small:
            return (width: 64, height: 64)
        case .placeDetail:
            return (width: 64, height: 64)
        case .myTrip:
            return (width: 64, height: 64)
        }
    }
}

/// Provides new link to resizing Images
public struct TRPImageResizer {
    
    public init() {}
    
    
    /// Gorsellerin yeniden boyutlandırılacağı linkleri standartlar dahilinde oluşturur
    /// - Parameters:
    ///   - url: Gorselin Url i
    ///   - standart: daha önceden belirlenmiş boyutları içerir.
    public static func generate(with url: String?, standart: TRPImageSizeStandart) -> String? {
        return generate(imageLink: url, width: standart.size.width, height: standart.size.height)
    }
    
    
    /// New link of image generater
    ///
    /// - Parameters:
    ///   - link: Image source link
    ///   - width: target width
    ///   - height: target height
    /// - Returns: new link 
    public static func generate(imageLink link: String?, width: Int, height: Int) -> String? {
        guard let url = link else {return nil}
        if let component = URLComponents(string: url) {
            let link = "https://d1drj6u6cu0e3j.cloudfront.net/\(width)x\(height)/smart\(component.path)"
            return link
        }
        return nil
    }
}
