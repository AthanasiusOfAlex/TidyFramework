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
    
    public init?(tidyBuffer: TidyBuffer) {
        
        let buffer: UnsafeMutablePointer<UInt8> = tidyBuffer.bp
        let size = Int(tidyBuffer.size)
        
        //  Just make sure our buffer is null-terminated.
        assert(buffer[size]==0, "Tidy buffer is not null terminated!")
        
        self = String(cString: buffer)
        
    }
    
    init?(tidyConstantString: ctmbstr?) {
        
        guard let tidyConstantString = tidyConstantString else { return nil }
        
        self = String(cString: tidyConstantString)
        
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
