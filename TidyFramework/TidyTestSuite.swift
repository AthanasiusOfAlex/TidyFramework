//
//  TidyTestSuite.swift
//  TidyFramework
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import Foundation
import Tidy
import TidyBufferIO

func testTidy() -> Int {
    
    let input = "<title>Foo</title><p>Foo!";
    
    var output = TidyBuffer()
    var errbuf = TidyBuffer()
    var tdoc = tidyCreate();
    
    tidyBufInit(&output)
    tidyBufInit(&errbuf)
    
    defer
    {
        tidyBufFree( &output );
        tidyBufFree( &errbuf );
        tidyRelease( tdoc );
    }
    
    print("Tidying:\t\(input)\n");
    
    let ok = tidyOptSetBool( tdoc, TidyXhtmlOut, yes )  // Convert to XHTML
    var rc: Int32 = -1
    
    
    if ok == yes {
        rc = tidySetErrorBuffer( tdoc, &errbuf )       // Capture diagnostics
    }
    if ( rc >= 0 ) {
        rc = tidyParseString( tdoc, input )            // Parse the input
    }
    if ( rc >= 0 ) {
        rc = tidyCleanAndRepair( tdoc )                // Tidy it up!
    }
    if ( rc >= 0 ) {
        rc = tidyRunDiagnostics( tdoc )                // Find any errors.
    }
    if ( rc > 1 ) {                                    // If error, force output
        rc = tidyOptSetBool(tdoc, TidyForceOutput, yes)==yes ? rc : -1
    }
    if ( rc >= 0 ) {
        rc = tidySaveBuffer( tdoc, &output );          // Pretty Print
    }
    if ( rc >= 0 )
    {
        if ( rc > 0 ) {
            print("\nDiagnostics:\n\n\(errbuf)");
            print("\nAnd here is the result:\n\n\(output)");
        }
    }
    else {
        print( "A severe error \(rc)) occurred.\\n");
    }
    
    
    return Int(rc);
}

// MARK - make it possible to convert a TidyBuffer to a string.
extension String {
    
    init(_ buffer: TidyBuffer) {
        
        var result = ""
        var bufferPointer = buffer.bp
        
        for _ in 0..<buffer.size-1 {
            
            let byte = Int(bufferPointer.memory)
            bufferPointer = bufferPointer.successor()
            
            let unicodeScalar = UnicodeScalar(byte)
            
            result.append(unicodeScalar)
            
        }
        
        self = result
        
    }
    
}

// MARK - make it possible to use a TidyBuffer as a variable by the print function
extension TidyBuffer: CustomStringConvertible {
    
    public var description: String {
        
        return String(self)
        
    }
    
}