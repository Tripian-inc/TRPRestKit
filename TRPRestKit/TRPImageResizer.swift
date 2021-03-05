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
            return devices()
        case .myTrip:
            return devices()
        }
    }
    
    public func devices() -> (width: Int, height: Int) {
        /*if UIDevice().userInterfaceIdiom == .phone {
            return (width: 800, height: 600)
        }*/
        return (width: 800, height: 800)
    }
}

/// Provides new link to resizing Images
public struct TRPImageResizer {
    
    public init() {}

    /// Gorsellerin yeniden boyutlandırılacağı linkleri standartlar dahilinde oluşturur
    /// - Parameters:
    ///   - url: Gorselin Url i
    ///   - standart: daha önceden belirlenmiş boyutları içerir.
    public static func generate(withUrl url: String?, standart: TRPImageSizeStandart) -> String? {
        
        return generate(withUrl: url, width: standart.size.width, height: standart.size.height)
    }
    
    /// New link of image generater
    ///
    /// - Parameters:
    ///   - link: Image source link
    ///   - width: target width
    ///   - height: target height
    /// - Returns: new link 
    public static func generate(withUrl link: String?, width: Int, height: Int) -> String? {
        guard let url = link, let component = URLComponents(string: url) else {return nil}
        
        return "https://d1drj6u6cu0e3j.cloudfront.net/\(width)x\(height)/smart\(component.path)"
    }
}
