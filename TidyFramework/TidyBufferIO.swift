//
//  TidyBufferIO.swift
//  TidyFramework
//
//  Created by Louis Melahn on 9/5/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import Foundation
import Tidy
import TidyBufferIO

// MARK - make it possible to convert a TidyBuffer to a string.
extension String {
    
    public init?(_ buffer: TidyBuffer) {
        
        let cString = UnsafeMutablePointer<Int8>(buffer.bp)
        
        if let newValue = String(validatingUTF8: cString!) {
            
            self = newValue
            
        } else {
        
            return nil
        
        }
        
    }
    
}

//// MARK - make it possible to use a TidyBuffer as a variable by the print function
//extension TidyBuffer: CustomStringConvertible {
//    
//    public var description: String {
//        
//        return String(self)
//        
//    }
//    
//}
