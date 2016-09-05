//
//  TidyDocument.swift
//  TidyFramework
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import Foundation

import Tidy

class TidyDocument {
    
    var tidyDoc = tidyCreate()
    
    var miscellaneousOptions: MiscellaneousOptions
    var markupOptions: MarkupOptions
    var prettyPrintOptions: PrettyPrintOptions
    var diagnosticsOptions: DiagnosticsOptions
    var characterEncodingOptions: CharacterEncodingOptions
    
    deinit {
        
        tidyRelease(tidyDoc)
    
    }
    
    init() {
        
        miscellaneousOptions = MiscellaneousOptions(tidyDoc: tidyDoc)
        markupOptions = MarkupOptions(tidyDoc: tidyDoc)
        prettyPrintOptions = PrettyPrintOptions(tidyDoc: tidyDoc)
        diagnosticsOptions = DiagnosticsOptions(tidyDoc: tidyDoc)
        characterEncodingOptions = CharacterEncodingOptions(tidyDoc: tidyDoc)
    
    }
    
    func resetAllOptionsToDefaults() {
        
        tidyOptResetAllToDefault(tidyDoc)
        
    }
    
}