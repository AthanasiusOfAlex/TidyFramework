//
//  TidyBridge.swift
//  TidyFramework
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import Foundation
import Tidy
import TidyBufferIO


// MARK - make it possible to convert a ctmbstr to a string.
extension String {
    
    init(_ tidyConstantString: ctmbstr) {
        
        var result = ""
        var moveableReference = tidyConstantString

        // This had better be a null-terminated string!!!
        while true {
            
            let byte = Int(moveableReference.memory)
            if byte==0 { break }
            
            moveableReference = moveableReference.successor()
            
            let unicodeScalar = UnicodeScalar(byte)
            
            result.append(unicodeScalar)
            
        }
        
        self = result
        
    }
    
}

enum YesNo {
    
    case yes
    case no
    
    init(_ tidyBool: Tidy.Bool) {
        
        switch tidyBool {
            
        case Tidy.yes:
            self = YesNo.yes
            
        case Tidy.no:
            self = YesNo.no
            
        default:
            self = YesNo.no
            
        }
        
    }
    
}

enum DocType: String {
    
    case omit
    case html5
    case auto
    case strict
    case loose
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let value = DocType(rawValue: String(tidyRawValue)) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

enum TriState: String {
    
    case yes
    case no
    case auto
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let value = TriState(rawValue: String(tidyRawValue)) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

enum NewlineType: String {
    
    case LF
    case CRLF
    case CR
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let value = NewlineType(rawValue: String(tidyRawValue)) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

enum RepeatedAttributeModes: String {
    
    case keepFirst
    case keepLast
    
    init(_ tidyRawValue: ctmbstr) {
        
        let tidyRawValue = String(tidyRawValue)
        
        switch tidyRawValue {
            
        case "keep-first":
            self = RepeatedAttributeModes.keepFirst
            
        case "keep-last":
            self = RepeatedAttributeModes.keepLast
            
        default:
            assert(false, "A bad value was used to initilize this enum. Check API.")
            self = RepeatedAttributeModes.keepFirst
            
        }
        
    }
    
}

enum AccessibilityCheckLevel: Int {
    
    case classic
    case priorityOneChecks
    case priorityTwoChecks
    case priorityThreeChecks
    
    init(_ tidyRawValue: ulong) {
        
        guard let value = AccessibilityCheckLevel(rawValue: Int(tidyRawValue)) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

enum AttributeSortStrategy: String {
    case none
    case alphabetical
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let value = AttributeSortStrategy(rawValue: String(tidyRawValue)) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

enum CharacterEncoding: String {
    
    case raw
    case ascii
    case latin0
    case latin1
    case utf8
    case iso2022
    case mac
    case win1252
    case ibm858
    case utf16le
    case utf16be
    case utf16
    case big5
    case shiftjis
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let value = CharacterEncoding(rawValue: String(tidyRawValue)) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

protocol TidyOptions { }


//======================
// Group: MiscellaneousOptions
//======================
struct MiscellaneousOptions: TidyOptions {
    
    var writeBack: YesNo
    var errorFile: String?
    var gnuEmacsFile: String?
    var keepTime: YesNo
    var quiet: YesNo
    var gnuEmacs: YesNo
    var tidyMark: YesNo
    var outputFile: String?
    var forceOutput: YesNo
    
    init(tidyDoc: TidyDoc) {
        
        writeBack = YesNo(tidyOptGetBool(tidyDoc, TidyWriteBack))
        keepTime = YesNo(tidyOptGetBool(tidyDoc, TidyKeepFileTimes))
        quiet = YesNo(tidyOptGetBool(tidyDoc, TidyQuiet))
        gnuEmacs = YesNo(tidyOptGetBool(tidyDoc, TidyEmacs))
        tidyMark = YesNo(tidyOptGetBool(tidyDoc, TidyMark))
        forceOutput = YesNo(tidyOptGetBool(tidyDoc, TidyForceOutput))
        
    }
    
}

//======================
// Group: MarkupOptions
//======================
struct MarkupOptions: TidyOptions {
    
    var outputXml: YesNo
    var joinClasses: YesNo
    var encloseText: YesNo
    var indentCdata: YesNo
    var mergeSpans: TriState
    var fixBackslash: YesNo
    var clean: YesNo
    
    #if SUPPORT_ASIAN_ENCODINGS
    var ncr: YesNo
    #endif
    
    var doctype: DocType
    var dropProprietaryAttributes: YesNo
    var uppercaseTags: YesNo
    var quoteMarks: YesNo
    var cssPrefix: String?
    var userDoctype: String?
    var outputHtml: YesNo
    var joinStyles: YesNo
    var decorateInferredUl: YesNo
    var newPreTags: String?
    var altText: String?
    var lowerLiterals: YesNo
    var coerceEndtags: YesNo
    var newInlineTags: String?
    var literalAttributes: YesNo
    var anchorAsName: YesNo
    var addXmlSpace: YesNo
    var inputXml: YesNo
    var skipNested: YesNo
    var dropEmptyParas: YesNo
    var replaceColor: YesNo
    var mergeEmphasis: YesNo
    var addXmlDecl: YesNo
    var bare: YesNo
    var hideEndtags: YesNo
    var outputXhtml: YesNo
    var uppercaseAttributes: YesNo
    var newEmptyTags: String?
    var preserveEntities: YesNo
    var numericEntities: YesNo
    var dropFontTags: YesNo
    var quoteNbsp: YesNo
    var dropEmptyElements: YesNo
    var logicalEmphasis: YesNo
    var omitOptionalTags: YesNo
    var encloseBlockText: YesNo
    var escapeCdata: YesNo
    var showBodyOnly: TriState
    var mergeDivs: TriState
    var gdoc: YesNo
    var word2000: YesNo
    var repeatedAttributes: RepeatedAttributeModes
    var quoteAmpersand: YesNo
    var fixBadComments: YesNo
    var strictTagsAttributes: YesNo
    var newBlocklevelTags: String?
    var fixUri: YesNo
    var assumeXmlProcins: YesNo
    var hideComments: YesNo
    
    init(tidyDoc: TidyDoc) {
        
        outputXml = YesNo(tidyOptGetBool(tidyDoc, TidyXmlOut))
        joinClasses = YesNo(tidyOptGetBool(tidyDoc, TidyJoinClasses))
        encloseText = YesNo(tidyOptGetBool(tidyDoc, TidyEncloseBodyText))
        indentCdata = YesNo(tidyOptGetBool(tidyDoc, TidyIndentCdata))
        mergeSpans = TriState(tidyOptGetCurrPick(tidyDoc, TidyMergeSpans))
        fixBackslash = YesNo(tidyOptGetBool(tidyDoc, TidyFixBackslash))
        clean = YesNo(tidyOptGetBool(tidyDoc, TidyMakeClean))
        
        #if SUPPORT_ASIAN_ENCODINGS
            ncr = YesNo(tidyOptGetBool(tidyDoc, TidyNCR))
        #endif
        
        doctype = DocType(tidyOptGetCurrPick(tidyDoc, TidyDoctypeMode))
        dropProprietaryAttributes = YesNo(tidyOptGetBool(tidyDoc, TidyDropPropAttrs))
        uppercaseTags = YesNo(tidyOptGetBool(tidyDoc, TidyUpperCaseTags))
        quoteMarks = YesNo(tidyOptGetBool(tidyDoc, TidyQuoteMarks))
        outputHtml = YesNo(tidyOptGetBool(tidyDoc, TidyHtmlOut))
        joinStyles = YesNo(tidyOptGetBool(tidyDoc, TidyJoinStyles))
        decorateInferredUl = YesNo(tidyOptGetBool(tidyDoc, TidyDecorateInferredUL))
        lowerLiterals = YesNo(tidyOptGetBool(tidyDoc, TidyLowerLiterals))
        coerceEndtags = YesNo(tidyOptGetBool(tidyDoc, TidyCoerceEndTags))
        literalAttributes = YesNo(tidyOptGetBool(tidyDoc, TidyLiteralAttribs))
        anchorAsName = YesNo(tidyOptGetBool(tidyDoc, TidyAnchorAsName))
        addXmlSpace = YesNo(tidyOptGetBool(tidyDoc, TidyXmlSpace))
        inputXml = YesNo(tidyOptGetBool(tidyDoc, TidyXmlTags))
        skipNested = YesNo(tidyOptGetBool(tidyDoc, TidySkipNested))
        dropEmptyParas = YesNo(tidyOptGetBool(tidyDoc, TidyDropEmptyParas))
        replaceColor = YesNo(tidyOptGetBool(tidyDoc, TidyReplaceColor))
        mergeEmphasis = YesNo(tidyOptGetBool(tidyDoc, TidyMergeEmphasis))
        addXmlDecl = YesNo(tidyOptGetBool(tidyDoc, TidyXmlDecl))
        bare = YesNo(tidyOptGetBool(tidyDoc, TidyMakeBare))
        hideEndtags = YesNo(tidyOptGetBool(tidyDoc, TidyHideEndTags))
        outputXhtml = YesNo(tidyOptGetBool(tidyDoc, TidyXhtmlOut))
        uppercaseAttributes = YesNo(tidyOptGetBool(tidyDoc, TidyUpperCaseAttrs))
        preserveEntities = YesNo(tidyOptGetBool(tidyDoc, TidyPreserveEntities))
        numericEntities = YesNo(tidyOptGetBool(tidyDoc, TidyNumEntities))
        dropFontTags = YesNo(tidyOptGetBool(tidyDoc, TidyDropFontTags))
        quoteNbsp = YesNo(tidyOptGetBool(tidyDoc, TidyQuoteNbsp))
        dropEmptyElements = YesNo(tidyOptGetBool(tidyDoc, TidyDropEmptyElems))
        logicalEmphasis = YesNo(tidyOptGetBool(tidyDoc, TidyLogicalEmphasis))
        omitOptionalTags = YesNo(tidyOptGetBool(tidyDoc, TidyOmitOptionalTags))
        encloseBlockText = YesNo(tidyOptGetBool(tidyDoc, TidyEncloseBlockText))
        escapeCdata = YesNo(tidyOptGetBool(tidyDoc, TidyEscapeCdata))
        showBodyOnly = TriState(tidyOptGetCurrPick(tidyDoc, TidyBodyOnly))
        mergeDivs = TriState(tidyOptGetCurrPick(tidyDoc, TidyMergeDivs))
        gdoc = YesNo(tidyOptGetBool(tidyDoc, TidyGDocClean))
        word2000 = YesNo(tidyOptGetBool(tidyDoc, TidyWord2000))
        repeatedAttributes = RepeatedAttributeModes(tidyOptGetCurrPick(tidyDoc, TidyDuplicateAttrs))
        quoteAmpersand = YesNo(tidyOptGetBool(tidyDoc, TidyQuoteAmpersand))
        fixBadComments = YesNo(tidyOptGetBool(tidyDoc, TidyFixComments))
        strictTagsAttributes = YesNo(tidyOptGetBool(tidyDoc, TidyStrictTagsAttr))
        fixUri = YesNo(tidyOptGetBool(tidyDoc, TidyFixUri))
        assumeXmlProcins = YesNo(tidyOptGetBool(tidyDoc, TidyXmlPIs))
        hideComments = YesNo(tidyOptGetBool(tidyDoc, TidyHideComments))
        
    }
    
}

//======================
// Group: PrettyPrintOptions
//======================
struct PrettyPrintOptions: TidyOptions {
    
    var indentSpaces: Int
    var escapeScripts: YesNo
    var indentWithTabs: YesNo
    var tabSize: Int
    var wrap: Int
    var indent: TriState
    var verticalSpace: TriState
    var wrapSections: YesNo
    var markup: YesNo
    var sortAttributes: AttributeSortStrategy
    var wrapAttributes: YesNo
    var indentAttributes: YesNo
    
    #if SUPPORT_ASIAN_ENCODINGS
    var punctuationWrap: YesNo
    #endif
    
    var wrapJste: YesNo
    var breakBeforeBr: YesNo
    var wrapPhp: YesNo
    var wrapScriptLiterals: YesNo
    var wrapAsp: YesNo
    
    init(tidyDoc: TidyDoc) {
        
        indentSpaces = Int(tidyOptGetInt(tidyDoc, TidyIndentSpaces))
        escapeScripts = YesNo(tidyOptGetBool(tidyDoc, TidyEscapeScripts))
        indentWithTabs = YesNo(tidyOptGetBool(tidyDoc, TidyPPrintTabs))
        tabSize = Int(tidyOptGetInt(tidyDoc, TidyTabSize))
        wrap = Int(tidyOptGetInt(tidyDoc, TidyWrapLen))
        indent = TriState(tidyOptGetCurrPick(tidyDoc, TidyIndentContent))
        verticalSpace = TriState(tidyOptGetCurrPick(tidyDoc, TidyVertSpace))
        wrapSections = YesNo(tidyOptGetBool(tidyDoc, TidyWrapSection))
        markup = YesNo(tidyOptGetBool(tidyDoc, TidyShowMarkup))
        sortAttributes = AttributeSortStrategy(tidyOptGetCurrPick(tidyDoc, TidySortAttributes))
        wrapAttributes = YesNo(tidyOptGetBool(tidyDoc, TidyWrapAttVals))
        indentAttributes = YesNo(tidyOptGetBool(tidyDoc, TidyIndentAttributes))
        
        #if SUPPORT_ASIAN_ENCODINGS
            punctuationWrap = YesNo(tidyOptGetBool(tidyDoc, TidyPunctWrap))
        #endif
        
        wrapJste = YesNo(tidyOptGetBool(tidyDoc, TidyWrapJste))
        breakBeforeBr = YesNo(tidyOptGetBool(tidyDoc, TidyBreakBeforeBR))
        wrapPhp = YesNo(tidyOptGetBool(tidyDoc, TidyWrapPhp))
        wrapScriptLiterals = YesNo(tidyOptGetBool(tidyDoc, TidyWrapScriptlets))
        wrapAsp = YesNo(tidyOptGetBool(tidyDoc, TidyWrapAsp))
        
    }
    
}

//======================
// Group: DiagnosticsOptions
//======================
struct DiagnosticsOptions: TidyOptions {
    
    var showInfo: YesNo
    var showWarnings: YesNo
    var showErrors: Int
    var accessibilityCheck: AccessibilityCheckLevel
    
    init(tidyDoc: TidyDoc) {
        
        showInfo = YesNo(tidyOptGetBool(tidyDoc, TidyShowInfo))
        showWarnings = YesNo(tidyOptGetBool(tidyDoc, TidyShowWarnings))
        showErrors = Int(tidyOptGetInt(tidyDoc, TidyShowErrors))
        accessibilityCheck = AccessibilityCheckLevel(tidyOptGetInt(tidyDoc, TidyAccessibilityCheckLevel))
        
    }
    
}

//======================
// Group: CharacterEncodingOptions
//======================
struct CharacterEncodingOptions: TidyOptions {
    
    var charEncoding: CharacterEncoding
    
    #if SUPPORT_ASIAN_ENCODINGS
    var language: String?
    #endif
    
    var outputEncoding: CharacterEncoding
    
    #if SUPPORT_UTF16_ENCODINGS
    var outputBom: TriState
    #endif
    
    var asciiChars: YesNo
    var newline: NewlineType
    var inputEncoding: CharacterEncoding
    
    init(tidyDoc: TidyDoc) {
        
        charEncoding = CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyCharEncoding))
        outputEncoding = CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyOutCharEncoding))
        
        #if SUPPORT_UTF16_ENCODINGS
            outputBom = TriState(tidyOptGetCurrPick(tidyDoc, TidyOutputBOM))
        #endif
        
        asciiChars = YesNo(tidyOptGetBool(tidyDoc, TidyAsciiChars))
        newline = NewlineType(tidyOptGetCurrPick(tidyDoc, TidyNewline))
        inputEncoding = CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyInCharEncoding))
        
    }
    
}
