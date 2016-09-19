//
//  TidyOptions.swift
//  TidyFramework
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import Foundation
import Tidy
import TidyBufferIO

// TODO -
//
// 1. Some way of detecting errors when setting options.

public enum YesNo {
    
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

public enum DocType: String {
    
    case omit
    case html5
    case auto
    case strict
    case loose
    case user
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard
            
            let rawValue = String(tidyConstantString: tidyRawValue),
            let value = DocType(rawValue: rawValue)
            
        else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

public enum TriState: String {
    
    case yes
    case no
    case auto
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard
            
            let rawValue = String(tidyConstantString: tidyRawValue),
            let value = TriState(rawValue: rawValue)
            
        else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

public enum NewlineType: String {
    
    case LF
    case CRLF
    case CR
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard
            
            let rawValue = String(tidyConstantString: tidyRawValue),
            let value = NewlineType(rawValue: rawValue)
            
        else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

public enum RepeatedAttributeModes: String {
    
    case keepFirst
    case keepLast
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard let tidyRawValue = String(tidyConstantString: tidyRawValue) else {
            
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

public enum AccessibilityCheckLevel: Int {
    
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

public enum AttributeSortStrategy: String {
    case none
    case alphabetical
    
    init(_ tidyRawValue: ctmbstr) {
        
        guard
            
            let rawValue = String(tidyConstantString: tidyRawValue),
            let value = AttributeSortStrategy(rawValue: rawValue)
            
        else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

public enum CharacterEncoding: String {
    
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
        
        guard
            
            let rawValue = String(tidyConstantString: tidyRawValue),
            let value = CharacterEncoding(rawValue: rawValue)
            
        else {
            
            assert(false, "A bad value was used to initilize this enum. Check API.")
            
        }
        
        self = value
        
    }
    
}

protocol TidyOptions { }

//======================
// Group: MiscellaneousOptions
//======================
public struct MiscellaneousOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    public var writeBack: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWriteBack))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "write-back", "\(newValue)")
            
        }
        
    }
    
    public var errorFile: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyErrFile))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "error-file", "\(newValue ?? "")")
            
        }
        
    }
    
    public var gnuEmacsFile: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyEmacsFile))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "gnu-emacs-file", "\(newValue ?? "")")
            
        }
        
    }
    
    public var keepTime: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyKeepFileTimes))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "keep-time", "\(newValue)")
            
        }
        
    }
    
    public var quiet: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuiet))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quiet", "\(newValue)")
            
        }
        
    }
    
    public var gnuEmacs: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEmacs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "gnu-emacs", "\(newValue)")
            
        }
        
    }
    
    public var tidyMark: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMark))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "tidy-mark", "\(newValue)")
            
        }
        
    }
    
    public var outputFile: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyOutFile))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-file", "\(newValue ?? "")")
            
        }
        
    }
    
    public var forceOutput: YesNo {
        
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
public struct MarkupOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    public var outputXml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlOut))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-xml", "\(newValue)")
            
        }
        
    }
    
    public var joinClasses: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyJoinClasses))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "join-classes", "\(newValue)")
            
        }
        
    }
    
    public var encloseText: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEncloseBodyText))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "enclose-text", "\(newValue)")
            
        }
        
    }
    
    public var indentCdata: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyIndentCdata))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-cdata", "\(newValue)")
            
        }
        
    }
    
    public var mergeSpans: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyMergeSpans))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "merge-spans", "\(newValue)")
            
        }
        
    }
    
    public var fixBackslash: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyFixBackslash))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "fix-backslash", "\(newValue)")
            
        }
        
    }
    
    public var clean: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMakeClean))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "clean", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_ASIAN_ENCODINGS
    public var ncr: YesNo {
    
        get {
    
            return YesNo(tidyOptGetBool(tidyDoc, TidyNCR))
    
        }
    
        set {
    
            tidyOptParseValue(tidyDoc, "ncr", "\(newValue)")
    
        }
    
    }
    #endif
    
    
    public var doctype: DocType {
        
        get {
            
            return DocType(tidyOptGetCurrPick(tidyDoc, TidyDoctypeMode))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "doctype", "\(newValue)")
            
        }
        
    }
    
    public var dropProprietaryAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropPropAttrs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-proprietary-attributes", "\(newValue)")
            
        }
        
    }
    
    public var uppercaseTags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyUpperCaseTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "uppercase-tags", "\(newValue)")
            
        }
        
    }
    
    public var quoteMarks: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuoteMarks))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quote-marks", "\(newValue)")
            
        }
        
    }
    
    public var cssPrefix: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyCSSPrefix))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "css-prefix", "\(newValue ?? "")")
            
        }
        
    }
    
    public var userDoctype: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyDoctype))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "doctype", "\"\(newValue ?? "")\"")
            
        }
        
    }
    
    public var outputHtml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyHtmlOut))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-html", "\(newValue)")
            
        }
        
    }
    
    public var joinStyles: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyJoinStyles))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "join-styles", "\(newValue)")
            
        }
        
    }
    
    public var decorateInferredUl: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDecorateInferredUL))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "decorate-inferred-ul", "\(newValue)")
            
        }
        
    }
    
    public var newPreTags: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyPreTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-pre-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    public var altText: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyAltText))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "alt-text", "\(newValue ?? "")")
            
        }
        
    }
    
    public var lowerLiterals: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyLowerLiterals))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "lower-literals", "\(newValue)")
            
        }
        
    }
    
    public var coerceEndtags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyCoerceEndTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "coerce-endtags", "\(newValue)")
            
        }
        
    }
    
    public var newInlineTags: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyInlineTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-inline-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    public var literalAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyLiteralAttribs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "literal-attributes", "\(newValue)")
            
        }
        
    }
    
    public var anchorAsName: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyAnchorAsName))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "anchor-as-name", "\(newValue)")
            
        }
        
    }
    
    public var addXmlSpace: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlSpace))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "add-xml-space", "\(newValue)")
            
        }
        
    }
    
    public var inputXml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "input-xml", "\(newValue)")
            
        }
        
    }
    
    public var skipNested: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidySkipNested))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "skip-nested", "\(newValue)")
            
        }
        
    }
    
    public var dropEmptyParas: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropEmptyParas))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-empty-paras", "\(newValue)")
            
        }
        
    }
    
    public var replaceColor: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyReplaceColor))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "replace-color", "\(newValue)")
            
        }
        
    }
    
    public var mergeEmphasis: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMergeEmphasis))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "merge-emphasis", "\(newValue)")
            
        }
        
    }
    
    public var addXmlDecl: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlDecl))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "add-xml-decl", "\(newValue)")
            
        }
        
    }
    
    public var bare: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyMakeBare))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "bare", "\(newValue)")
            
        }
        
    }
    
    public var hideEndtags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyHideEndTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "hide-endtags", "\(newValue)")
            
        }
        
    }
    
    public var outputXhtml: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXhtmlOut))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-xhtml", "\(newValue)")
            
        }
        
    }
    
    public var uppercaseAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyUpperCaseAttrs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "uppercase-attributes", "\(newValue)")
            
        }
        
    }
    
    public var newEmptyTags: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyEmptyTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-empty-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    public var preserveEntities: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyPreserveEntities))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "preserve-entities", "\(newValue)")
            
        }
        
    }
    
    public var numericEntities: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyNumEntities))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "numeric-entities", "\(newValue)")
            
        }
        
    }
    
    public var dropFontTags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropFontTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-font-tags", "\(newValue)")
            
        }
        
    }
    
    public var quoteNbsp: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuoteNbsp))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quote-nbsp", "\(newValue)")
            
        }
        
    }
    
    public var dropEmptyElements: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyDropEmptyElems))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "drop-empty-elements", "\(newValue)")
            
        }
        
    }
    
    public var logicalEmphasis: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyLogicalEmphasis))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "logical-emphasis", "\(newValue)")
            
        }
        
    }
    
    public var omitOptionalTags: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyOmitOptionalTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "omit-optional-tags", "\(newValue)")
            
        }
        
    }
    
    public var encloseBlockText: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEncloseBlockText))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "enclose-block-text", "\(newValue)")
            
        }
        
    }
    
    public var escapeCdata: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEscapeCdata))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "escape-cdata", "\(newValue)")
            
        }
        
    }
    
    public var showBodyOnly: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyBodyOnly))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-body-only", "\(newValue)")
            
        }
        
    }
    
    public var mergeDivs: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyMergeDivs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "merge-divs", "\(newValue)")
            
        }
        
    }
    
    public var gdoc: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyGDocClean))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "gdoc", "\(newValue)")
            
        }
        
    }
    
    public var word2000: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWord2000))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "word-2000", "\(newValue)")
            
        }
        
    }
    
    public var repeatedAttributes: RepeatedAttributeModes {
        
        get {
            
            return RepeatedAttributeModes(tidyOptGetCurrPick(tidyDoc, TidyDuplicateAttrs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "repeated-attributes", "\(newValue)")
            
        }
        
    }
    
    public var quoteAmpersand: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyQuoteAmpersand))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "quote-ampersand", "\(newValue)")
            
        }
        
    }
    
    public var fixBadComments: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyFixComments))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "fix-bad-comments", "\(newValue)")
            
        }
        
    }
    
    public var strictTagsAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyStrictTagsAttr))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "strict-tags-attributes", "\(newValue)")
            
        }
        
    }
    
    public var newBlocklevelTags: String? {
        
        get {
            
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyBlockTags))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "new-blocklevel-tags", "\(newValue ?? "")")
            
        }
        
    }
    
    public var fixUri: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyFixUri))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "fix-uri", "\(newValue)")
            
        }
        
    }
    
    public var assumeXmlProcins: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyXmlPIs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "assume-xml-procins", "\(newValue)")
            
        }
        
    }
    
    public var hideComments: YesNo {
        
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
public struct PrettyPrintOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    public var indentSpaces: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyIndentSpaces))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-spaces", "\(newValue)")
            
        }
        
    }
    
    /// Escape items that look like closing tags in script tags
    public var escapeScripts: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyEscapeScripts))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "escape-scripts", "\(newValue)")
            
        }
        
    }
    
    public var indentWithTabs: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyPPrintTabs))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-with-tabs", "\(newValue)")
            
        }
        
    }
    
    public var tabSize: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyTabSize))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "tab-size", "\(newValue)")
            
        }
        
    }
    
    public var wrap: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyWrapLen))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap", "\(newValue)")
            
        }
        
    }
    
    public var indent: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyIndentContent))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent", "\(newValue)")
            
        }
        
    }
    
    public var verticalSpace: TriState {
        
        get {
            
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyVertSpace))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "vertical-space", "\(newValue)")
            
        }
        
    }
    
    public var wrapSections: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapSection))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-sections", "\(newValue)")
            
        }
        
    }
    
    public var markup: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyShowMarkup))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "markup", "\(newValue)")
            
        }
        
    }
    
    public var sortAttributes: AttributeSortStrategy {
        
        get {
            
            return AttributeSortStrategy(tidyOptGetCurrPick(tidyDoc, TidySortAttributes))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "sort-attributes", "\(newValue)")
            
        }
        
    }
    
    public var wrapAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapAttVals))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-attributes", "\(newValue)")
            
        }
        
    }
    
    public var indentAttributes: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyIndentAttributes))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "indent-attributes", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_ASIAN_ENCODINGS
    public var punctuationWrap: YesNo {
    
        get {
    
            return YesNo(tidyOptGetBool(tidyDoc, TidyPunctWrap))
    
        }
    
        set {
    
            tidyOptParseValue(tidyDoc, "punctuation-wrap", "\(newValue)")
    
        }
    
    }
    #endif
    
    
    public var wrapJste: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapJste))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-jste", "\(newValue)")
            
        }
        
    }
    
    public var breakBeforeBr: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyBreakBeforeBR))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "break-before-br", "\(newValue)")
            
        }
        
    }
    
    public var wrapPhp: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapPhp))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-php", "\(newValue)")
            
        }
        
    }
    
    public var wrapScriptLiterals: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyWrapScriptlets))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "wrap-script-literals", "\(newValue)")
            
        }
        
    }
    
    public var wrapAsp: YesNo {
        
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
public struct DiagnosticsOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    public var showInfo: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyShowInfo))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-info", "\(newValue)")
            
        }
        
    }
    
    public var showWarnings: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyShowWarnings))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-warnings", "\(newValue)")
            
        }
        
    }
    
    public var showErrors: Int {
        
        get {
            
            return Int(tidyOptGetInt(tidyDoc, TidyShowErrors))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "show-errors", "\(newValue)")
            
        }
        
    }
    
    public var accessibilityCheck: AccessibilityCheckLevel {
        
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
public struct CharacterEncodingOptions: TidyOptions {
    
    var tidyDoc: TidyDoc
    
    public var charEncoding: CharacterEncoding {
        
        get {
            
            return CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyCharEncoding))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "char-encoding", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_ASIAN_ENCODINGS
    public var language: String? {
    
        get {
    
            return String(tidyConstantString: tidyOptGetValue(tidyDoc, TidyLanguage))
    
        }
    
        set {
    
            tidyOptParseValue(tidyDoc, "language", "\(newValue ?? "")")
    
        }
    
    }
    #endif
    
    
    public var outputEncoding: CharacterEncoding {
        
        get {
            
            return CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyOutCharEncoding))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "output-encoding", "\(newValue)")
            
        }
        
    }
    
    
    #if SUPPORT_UTF16_ENCODINGS
    public var outputBom: TriState {
    
        get {
    
            return TriState(tidyOptGetCurrPick(tidyDoc, TidyOutputBOM))
    
        }
    
        set {
    
            tidyOptParseValue(tidyDoc, "output-bom", "\(newValue)")
    
        }
    
    }
    #endif
    
    
    public var asciiChars: YesNo {
        
        get {
            
            return YesNo(tidyOptGetBool(tidyDoc, TidyAsciiChars))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "ascii-chars", "\(newValue)")
            
        }
        
    }
    
    public var newline: NewlineType {
        
        get {
            
            return NewlineType(tidyOptGetCurrPick(tidyDoc, TidyNewline))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "newline", "\(newValue)")
            
        }
        
    }
    
    public var inputEncoding: CharacterEncoding {
        
        get {
            
            return CharacterEncoding(tidyOptGetEncName(tidyDoc, TidyInCharEncoding))
            
        }
        
        set {
            
            tidyOptParseValue(tidyDoc, "input-encoding", "\(newValue)")
            
        }
        
    }
    
}
