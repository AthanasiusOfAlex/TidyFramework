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
    
// Old implementation (which still works)
//    init?(_ tidyConstantString: ctmbstr) {
//        
//        if tidyConstantString.hashValue==0 { return nil }
//        
//        var result = ""
//        var moveableReference = tidyConstantString
//        
//        // This had better be a null-terminated string!!!
//        while true {
//            
//            let byte = Int(moveableReference.memory)
//            if byte==0 { break }
//            
//            moveableReference = moveableReference.successor()
//            
//            let unicodeScalar = UnicodeScalar(byte)
//            
//            result.append(unicodeScalar)
//            
//        }
//        
//        self = result
//        
//    }

    init?(_ tidyConstantString: ctmbstr) {
        
        if let swiftString = String.fromCString(tidyConstantString) {
            
            self = swiftString
            
        } else {
            
            return nil
            
        }
        
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
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
    }
    
}

enum DocType: String {
    
    case omit
    case html5
    case auto
    case strict
    case loose
    case user
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let rawValue = String(tidyRawValue), let value = DocType(rawValue: rawValue) else {
            
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
        
        guard let rawValue = String(tidyRawValue), let value = TriState(rawValue: rawValue) else {
            
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
        
        guard let rawValue = String(tidyRawValue), let value = NewlineType(rawValue: rawValue) else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

enum RepeatedAttributeModes: String {
    
    case keepFirst
    case keepLast
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let tidyRawValue = String(tidyRawValue) else {
            
            assert(false, "A nil (i.e., no value) was used to initilize this enum. Check API.")
        
        }
        
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
        
        guard let rawValue = String(tidyRawValue), let value = AttributeSortStrategy(rawValue: rawValue) else {
            
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
        
        guard let rawValue = String(tidyRawValue), let value = CharacterEncoding(rawValue: rawValue) else {
            
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
    
    var tidyDoc: TidyDoc
    
    var writeBack: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWriteBack))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "write-back", "\(newValue)")
            
        }
        
    }
    
    var errorFile: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyErrFile))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "error-file", "\(newValue ?? "")")
            
        }
        
    }
    
    var gnuEmacsFile: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyEmacsFile))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "gnu-emacs-file", "\(newValue ?? "")")
            
        }
        
    }
    
    var keepTime: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyKeepFileTimes))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "keep-time", "\(newValue)")
            
        }
        
    }
    
    var quiet: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuiet))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quiet", "\(newValue)")
            
        }
        
    }
    
    var gnuEmacs: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEmacs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "gnu-emacs", "\(newValue)")
            
        }
        
    }
    
    var tidyMark: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMark))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "tidy-mark", "\(newValue)")
            
        }
        
    }
    
    var outputFile: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyOutFile))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-file", "\(newValue ?? "")")
            
        }
        
    }
    
    var forceOutput: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyForceOutput))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "force-output", "\(newValue)")
            
        }
        
    }
    
}

//======================
// Group: MarkupOptions
//======================
struct MarkupOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    var outputXml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlOut))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-xml", "\(newValue)")
            
        }
        
    }
    
    var joinClasses: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyJoinClasses))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "join-classes", "\(newValue)")
            
        }
        
    }
    
    var encloseText: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEncloseBodyText))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "enclose-text", "\(newValue)")
            
        }
        
    }
    
    var indentCdata: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyIndentCdata))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-cdata", "\(newValue)")
            
        }
        
    }
    
    var mergeSpans: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyMergeSpans))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "merge-spans", "\(newValue)")
            
        }
        
    }
    
    var fixBackslash: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyFixBackslash))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "fix-backslash", "\(newValue)")
            
        }
        
    }
    
    var clean: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMakeClean))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "clean", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_ASIAN_ENCODINGS
    var ncr: YesNo {
    
    get {
    
    return YesNo(tidyOptGetBool(tidyDoc, TidyNCR))
    
    }
    
    set {
    
    tidyOptParseValue(tidyDoc, "ncr", "\(newValue)")
    
    }
    
    }
    #endif
    
    
    var doctype: DocType {
        
        get {
            
            return DocType(tidyOptGetCurrPick(tidyDoc, TidyDoctypeMode))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "doctype", "\(newValue)")
            
        }
        
    }
    
    var dropProprietaryAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropPropAttrs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-proprietary-attributes", "\(newValue)")
            
        }
        
    }
    
    var uppercaseTags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyUpperCaseTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "uppercase-tags", "\(newValue)")
            
        }
        
    }
    
    var quoteMarks: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuoteMarks))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quote-marks", "\(newValue)")
            
        }
        
    }
    
    var cssPrefix: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyCSSPrefix))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "css-prefix", "\(newValue ?? "")")
            
        }
        
    }
    
    var userDoctype: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyDoctype))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "doctype", "\"\(newValue ?? "")\"")
            
        }
        
    }
    
    var outputHtml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyHtmlOut))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-html", "\(newValue)")
            
        }
        
    }
    
    var joinStyles: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyJoinStyles))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "join-styles", "\(newValue)")
            
        }
        
    }
    
    var decorateInferredUl: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDecorateInferredUL))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "decorate-inferred-ul", "\(newValue)")
            
        }
        
    }
    
    var newPreTags: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyPreTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-pre-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    var altText: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyAltText))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "alt-text", "\(newValue ?? "")")
            
        }
        
    }
    
    var lowerLiterals: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyLowerLiterals))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "lower-literals", "\(newValue)")
            
        }
        
    }
    
    var coerceEndtags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyCoerceEndTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "coerce-endtags", "\(newValue)")
            
        }
        
    }
    
    var newInlineTags: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyInlineTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-inline-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    var literalAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyLiteralAttribs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "literal-attributes", "\(newValue)")
            
        }
        
    }
    
    var anchorAsName: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyAnchorAsName))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "anchor-as-name", "\(newValue)")
            
        }
        
    }
    
    var addXmlSpace: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlSpace))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "add-xml-space", "\(newValue)")
            
        }
        
    }
    
    var inputXml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "input-xml", "\(newValue)")
            
        }
        
    }
    
    var skipNested: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidySkipNested))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "skip-nested", "\(newValue)")
            
        }
        
    }
    
    var dropEmptyParas: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropEmptyParas))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-empty-paras", "\(newValue)")
            
        }
        
    }
    
    var replaceColor: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyReplaceColor))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "replace-color", "\(newValue)")
            
        }
        
    }
    
    var mergeEmphasis: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMergeEmphasis))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "merge-emphasis", "\(newValue)")
            
        }
        
    }
    
    var addXmlDecl: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlDecl))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "add-xml-decl", "\(newValue)")
            
        }
        
    }
    
    var bare: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMakeBare))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "bare", "\(newValue)")
            
        }
        
    }
    
    var hideEndtags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyHideEndTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "hide-endtags", "\(newValue)")
            
        }
        
    }
    
    var outputXhtml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXhtmlOut))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-xhtml", "\(newValue)")
            
        }
        
    }
    
    var uppercaseAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyUpperCaseAttrs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "uppercase-attributes", "\(newValue)")
            
        }
        
    }
    
    var newEmptyTags: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyEmptyTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-empty-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    var preserveEntities: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyPreserveEntities))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "preserve-entities", "\(newValue)")
            
        }
        
    }
    
    var numericEntities: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyNumEntities))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "numeric-entities", "\(newValue)")
            
        }
        
    }
    
    var dropFontTags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropFontTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-font-tags", "\(newValue)")
            
        }
        
    }
    
    var quoteNbsp: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuoteNbsp))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quote-nbsp", "\(newValue)")
            
        }
        
    }
    
    var dropEmptyElements: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropEmptyElems))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-empty-elements", "\(newValue)")
            
        }
        
    }
    
    var logicalEmphasis: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyLogicalEmphasis))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "logical-emphasis", "\(newValue)")
            
        }
        
    }
    
    var omitOptionalTags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyOmitOptionalTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "omit-optional-tags", "\(newValue)")
            
        }
        
    }
    
    var encloseBlockText: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEncloseBlockText))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "enclose-block-text", "\(newValue)")
            
        }
        
    }
    
    var escapeCdata: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEscapeCdata))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "escape-cdata", "\(newValue)")
            
        }
        
    }
    
    var showBodyOnly: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyBodyOnly))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-body-only", "\(newValue)")
            
        }
        
    }
    
    var mergeDivs: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyMergeDivs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "merge-divs", "\(newValue)")
            
        }
        
    }
    
    var gdoc: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyGDocClean))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "gdoc", "\(newValue)")
            
        }
        
    }
    
    var word2000: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWord2000))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "word-2000", "\(newValue)")
            
        }
        
    }
    
    var repeatedAttributes: RepeatedAttributeModes {
        
        get {
            
            return RepeatedAttributeModes(tidyOptGetCurrPick(tidyDoc, TidyDuplicateAttrs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "repeated-attributes", "\(newValue)")
            
        }
        
    }
    
    var quoteAmpersand: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuoteAmpersand))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quote-ampersand", "\(newValue)")
            
        }
        
    }
    
    var fixBadComments: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyFixComments))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "fix-bad-comments", "\(newValue)")
            
        }
        
    }
    
    var strictTagsAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyStrictTagsAttr))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "strict-tags-attributes", "\(newValue)")
            
        }
        
    }
    
    var newBlocklevelTags: String? {
        
        get {
            
            return String(tidyOptGetValue(tidyDoc, TidyBlockTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-blocklevel-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    var fixUri: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyFixUri))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "fix-uri", "\(newValue)")
            
        }
        
    }
    
    var assumeXmlProcins: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlPIs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "assume-xml-procins", "\(newValue)")
            
        }
        
    }
    
    var hideComments: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyHideComments))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "hide-comments", "\(newValue)")
            
        }
        
    }
    
}

//======================
// Group: PrettyPrintOptions
//======================
struct PrettyPrintOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    var indentSpaces: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyIndentSpaces))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-spaces", "\(newValue)")
            
        }
        
    }
    
    var escapeScripts: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEscapeScripts))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "escape-scripts", "\(newValue)")
            
        }
        
    }
    
    var indentWithTabs: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyPPrintTabs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-with-tabs", "\(newValue)")
            
        }
        
    }
    
    var tabSize: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyTabSize))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "tab-size", "\(newValue)")
            
        }
        
    }
    
    var wrap: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyWrapLen))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap", "\(newValue)")
            
        }
        
    }
    
    var indent: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyIndentContent))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent", "\(newValue)")
            
        }
        
    }
    
    var verticalSpace: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyVertSpace))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "vertical-space", "\(newValue)")
            
        }
        
    }
    
    var wrapSections: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapSection))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-sections", "\(newValue)")
            
        }
        
    }
    
    var markup: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyShowMarkup))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "markup", "\(newValue)")
            
        }
        
    }
    
    var sortAttributes: AttributeSortStrategy {
        
        get {
            
            return AttributeSortStrategy(tidyOptGetCurrPick(tidyDoc, TidySortAttributes))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "sort-attributes", "\(newValue)")
            
        }
        
    }
    
    var wrapAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapAttVals))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-attributes", "\(newValue)")
            
        }
        
    }
    
    var indentAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyIndentAttributes))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-attributes", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_ASIAN_ENCODINGS
    var punctuationWrap: YesNo {
    
    get {
    
    return YesNo(tidyOptGetBool(tidyDoc, TidyPunctWrap))
    
    }
    
    set {
    
    tidyOptParseValue(tidyDoc, "punctuation-wrap", "\(newValue)")
    
    }
    
    }
    #endif
    
    
    var wrapJste: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapJste))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-jste", "\(newValue)")
            
        }
        
    }
    
    var breakBeforeBr: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyBreakBeforeBR))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "break-before-br", "\(newValue)")
            
        }
        
    }
    
    var wrapPhp: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapPhp))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-php", "\(newValue)")
            
        }
        
    }
    
    var wrapScriptLiterals: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapScriptlets))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-script-literals", "\(newValue)")
            
        }
        
    }
    
    var wrapAsp: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapAsp))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-asp", "\(newValue)")
            
        }
        
    }
    
}

//======================
// Group: DiagnosticsOptions
//======================
struct DiagnosticsOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    var showInfo: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyShowInfo))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-info", "\(newValue)")
            
        }
        
    }
    
    var showWarnings: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyShowWarnings))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-warnings", "\(newValue)")
            
        }
        
    }
    
    var showErrors: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyShowErrors))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-errors", "\(newValue)")
            
        }
        
    }
    
    var accessibilityCheck: AccessibilityCheckLevel {
        
        get {
            
            return AccessibilityCheckLevel(tidyOptGetInt(tidyDoc, TidyAccessibilityCheckLevel))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "accessibility-check", "\(newValue)")
            
        }
        
    }
    
}

//======================
// Group: CharacterEncodingOptions
//======================
struct CharacterEncodingOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    var charEncoding: CharacterEncoding {
        
        get {
            
            return CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyCharEncoding))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "char-encoding", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_ASIAN_ENCODINGS
    var language: String? {
    
    get {
    
    return String(tidyOptGetValue(tidyDoc, TidyLanguage))
    
    }
    
    set {
    
    tidyOptParseValue(tidyDoc, "language", "\(newValue ?? "")")
    
    }
    
    }
    #endif
    
    
    var outputEncoding: CharacterEncoding {
        
        get {
            
            return CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyOutCharEncoding))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-encoding", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_UTF16_ENCODINGS
    var outputBom: TriState {
    
    get {
    
    return TriState(tidyOptGetCurrPick(tidyDoc, TidyOutputBOM))
    
    }
    
    set {
    
    tidyOptParseValue(tidyDoc, "output-bom", "\(newValue)")
    
    }
    
    }
    #endif
    
    
    var asciiChars: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyAsciiChars))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "ascii-chars", "\(newValue)")
            
        }
        
    }
    
    var newline: NewlineType {
        
        get {
            
            return NewlineType(tidyOptGetCurrPick(tidyDoc, TidyNewline))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "newline", "\(newValue)")
            
        }
        
    }
    
    var inputEncoding: CharacterEncoding {
        
        get {
            
            return CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyInCharEncoding))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "input-encoding", "\(newValue)")
            
        }
        
    }
    
}