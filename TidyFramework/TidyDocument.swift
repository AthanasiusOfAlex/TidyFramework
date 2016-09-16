//
//  TidyDocument.swift
//  TidyFramework
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import Foundation

import Tidy
import TidyBufferIO

open class TidyDocument {
    
    var tidyDoc = tidyCreate()
    
    open var miscellaneousOptions: MiscellaneousOptions
    open var markupOptions: MarkupOptions
    open var prettyPrintOptions: PrettyPrintOptions
    open var diagnosticsOptions: DiagnosticsOptions
    open var characterEncodingOptions: CharacterEncodingOptions
    
    open var tidiedText: String? {
        
        guard let originalText = originalText else { return nil }

        // Parse the input
        var errorCode = tidyParseString(tidyDoc, originalText)
        guard errorCode >= 0 else { return nil }
        
        // Clean up
        errorCode = tidyCleanAndRepair(tidyDoc)
        guard errorCode >= 0 else { return nil }
    
        // Save the cleaned text to the buffer.
        errorCode = tidySaveBuffer(tidyDoc, &mainBuffer);
        guard errorCode >= 0 else { return nil }
        
        // Return it!
        return String(tidyBuffer: mainBuffer)
        
    }

    open var originalText: String?
    
    var mainBuffer = TidyBuffer()
    var errorBuffer = TidyBuffer()
    
    deinit {
        
        tidyBufFree(&errorBuffer);
        tidyBufFree(&mainBuffer);
        tidyRelease(tidyDoc)
    
    }
    
    public init() {
        
        miscellaneousOptions = MiscellaneousOptions(tidyDoc: tidyDoc!)
        markupOptions = MarkupOptions(tidyDoc: tidyDoc!)
        prettyPrintOptions = PrettyPrintOptions(tidyDoc: tidyDoc!)
        diagnosticsOptions = DiagnosticsOptions(tidyDoc: tidyDoc!)
        characterEncodingOptions = CharacterEncodingOptions(tidyDoc: tidyDoc!)
        
        tidyBufInit(&mainBuffer)
        tidyBufInit(&errorBuffer)
        
    }
    
    func resetAllOptionsToDefaults() {
        
        tidyOptResetAllToDefault(tidyDoc)
        
    }
    
}
