//
//  TidyFrameworkTests.swift
//  TidyFrameworkTests
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import XCTest
@testable import TidyFramework
import TidyEnum

class TidyFrameworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTidyDocumentCreation() {
        
        // TEST - testTidy should return a value that is > 0. Otherwise the tidy library
        XCTAssert(testTidy()>0, "Something is wrong with the Tidy library, because an error has occurred.")
    }
    
    func testDefaultOptions() {
        
        let tidyDocument = TidyDocument()
        
        // TEST - These are the defaults that should be read in a new Tidy Document.
        XCTAssert(tidyDocument.miscellaneousOptions.writeBack == .no)
        XCTAssert(tidyDocument.miscellaneousOptions.errorFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.gnuEmacsFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.keepTime == .no)
        XCTAssert(tidyDocument.miscellaneousOptions.quiet == .no)
        XCTAssert(tidyDocument.miscellaneousOptions.gnuEmacs == .no)
        XCTAssert(tidyDocument.miscellaneousOptions.tidyMark == .yes)
        XCTAssert(tidyDocument.miscellaneousOptions.outputFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.forceOutput == .no)
        XCTAssert(tidyDocument.markupOptions.outputXml == .no)
        XCTAssert(tidyDocument.markupOptions.joinClasses == .no)
        XCTAssert(tidyDocument.markupOptions.encloseText == .no)
        XCTAssert(tidyDocument.markupOptions.indentCdata == .no)
        XCTAssert(tidyDocument.markupOptions.mergeSpans == .auto)
        XCTAssert(tidyDocument.markupOptions.fixBackslash == .yes)
        XCTAssert(tidyDocument.markupOptions.clean == .no)
        XCTAssert(tidyDocument.markupOptions.doctype == .auto)
        XCTAssert(tidyDocument.markupOptions.dropProprietaryAttributes == .no)
        XCTAssert(tidyDocument.markupOptions.uppercaseTags == .no)
        XCTAssert(tidyDocument.markupOptions.quoteMarks == .no)
        XCTAssert(tidyDocument.markupOptions.cssPrefix == nil)
        XCTAssert(tidyDocument.markupOptions.userDoctype == nil)
        XCTAssert(tidyDocument.markupOptions.outputHtml == .no)
        XCTAssert(tidyDocument.markupOptions.joinStyles == .yes)
        XCTAssert(tidyDocument.markupOptions.decorateInferredUl == .no)
        XCTAssert(tidyDocument.markupOptions.newPreTags == nil)
        XCTAssert(tidyDocument.markupOptions.altText == nil)
        XCTAssert(tidyDocument.markupOptions.lowerLiterals == .yes)
        XCTAssert(tidyDocument.markupOptions.coerceEndtags == .yes)
        XCTAssert(tidyDocument.markupOptions.newInlineTags == nil)
        XCTAssert(tidyDocument.markupOptions.literalAttributes == .no)
        XCTAssert(tidyDocument.markupOptions.anchorAsName == .yes)
        XCTAssert(tidyDocument.markupOptions.addXmlSpace == .no)
        XCTAssert(tidyDocument.markupOptions.inputXml == .no)
        XCTAssert(tidyDocument.markupOptions.skipNested == .yes)
        XCTAssert(tidyDocument.markupOptions.dropEmptyParas == .yes)
        XCTAssert(tidyDocument.markupOptions.replaceColor == .no)
        XCTAssert(tidyDocument.markupOptions.mergeEmphasis == .yes)
        XCTAssert(tidyDocument.markupOptions.addXmlDecl == .no)
        XCTAssert(tidyDocument.markupOptions.bare == .no)
        XCTAssert(tidyDocument.markupOptions.hideEndtags == .no)
        XCTAssert(tidyDocument.markupOptions.outputXhtml == .no)
        XCTAssert(tidyDocument.markupOptions.uppercaseAttributes == .no)
        XCTAssert(tidyDocument.markupOptions.newEmptyTags == nil)
        XCTAssert(tidyDocument.markupOptions.preserveEntities == .no)
        XCTAssert(tidyDocument.markupOptions.numericEntities == .no)
        XCTAssert(tidyDocument.markupOptions.dropFontTags == .no)
        XCTAssert(tidyDocument.markupOptions.quoteNbsp == .yes)
        XCTAssert(tidyDocument.markupOptions.dropEmptyElements == .yes)
        XCTAssert(tidyDocument.markupOptions.logicalEmphasis == .no)
        XCTAssert(tidyDocument.markupOptions.omitOptionalTags == .no)
        XCTAssert(tidyDocument.markupOptions.encloseBlockText == .no)
        XCTAssert(tidyDocument.markupOptions.escapeCdata == .no)
        XCTAssert(tidyDocument.markupOptions.showBodyOnly == .no)
        XCTAssert(tidyDocument.markupOptions.mergeDivs == .auto)
        XCTAssert(tidyDocument.markupOptions.gdoc == .no)
        XCTAssert(tidyDocument.markupOptions.word2000 == .no)
        XCTAssert(tidyDocument.markupOptions.repeatedAttributes == .keepLast)
        XCTAssert(tidyDocument.markupOptions.quoteAmpersand == .yes)
        XCTAssert(tidyDocument.markupOptions.fixBadComments == .yes)
        XCTAssert(tidyDocument.markupOptions.strictTagsAttributes == .no)
        XCTAssert(tidyDocument.markupOptions.newBlocklevelTags == nil)
        XCTAssert(tidyDocument.markupOptions.fixUri == .yes)
        XCTAssert(tidyDocument.markupOptions.assumeXmlProcins == .no)
        XCTAssert(tidyDocument.markupOptions.hideComments == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.indentSpaces == 2)
        XCTAssert(tidyDocument.prettyPrintOptions.escapeScripts == .yes)
        XCTAssert(tidyDocument.prettyPrintOptions.indentWithTabs == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.tabSize == 8)
        XCTAssert(tidyDocument.prettyPrintOptions.wrap == 68)
        XCTAssert(tidyDocument.prettyPrintOptions.indent == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.verticalSpace == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapSections == .yes)
        XCTAssert(tidyDocument.prettyPrintOptions.markup == .yes)
        XCTAssert(tidyDocument.prettyPrintOptions.sortAttributes == .none)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapAttributes == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.indentAttributes == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapJste == .yes)
        XCTAssert(tidyDocument.prettyPrintOptions.breakBeforeBr == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapPhp == .yes)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapScriptLiterals == .no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapAsp == .yes)
        XCTAssert(tidyDocument.diagnosticsOptions.showInfo == .yes)
        XCTAssert(tidyDocument.diagnosticsOptions.showWarnings == .yes)
        XCTAssert(tidyDocument.diagnosticsOptions.showErrors == 6)
        XCTAssert(tidyDocument.diagnosticsOptions.accessibilityCheck == .classic)
        XCTAssert(tidyDocument.characterEncodingOptions.charEncoding == .utf8)
        XCTAssert(tidyDocument.characterEncodingOptions.outputEncoding == .utf8)
        XCTAssert(tidyDocument.characterEncodingOptions.asciiChars == .no)
        XCTAssert(tidyDocument.characterEncodingOptions.newline == .LF)
        XCTAssert(tidyDocument.characterEncodingOptions.inputEncoding == .utf8)
        
    }
    
    func testSettingOptions() {
        
        // TEST - Some tests to make sure that setting options works
        
        let tidyDocument = TidyDocument()
        
        tidyDocument.prettyPrintOptions.indentSpaces = 234
        XCTAssert(tidyDocument.prettyPrintOptions.indentSpaces == 234)
        
        tidyDocument.miscellaneousOptions.errorFile = "foobar"
        XCTAssert(tidyDocument.miscellaneousOptions.errorFile == "foobar")
        
        tidyDocument.miscellaneousOptions.forceOutput = .yes
        XCTAssert(tidyDocument.miscellaneousOptions.forceOutput == .yes)
        
        tidyDocument.markupOptions.mergeSpans = .no
        XCTAssert(tidyDocument.markupOptions.mergeSpans == .no)
        
        tidyDocument.resetAllOptionsToDefaults()
        XCTAssert(tidyDocument.prettyPrintOptions.indentSpaces == 2)
        XCTAssert(tidyDocument.miscellaneousOptions.errorFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.forceOutput == .no)
        XCTAssert(tidyDocument.markupOptions.mergeSpans == .auto)

        // TEST - Doctype
        
        // The following is a user-defined doctype (taken from the API).
        // It should work, and the doctype mode shoudl change from `auto` to `user`:
        XCTAssert(tidyDocument.markupOptions.doctype == .auto)
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        XCTAssert(tidyDocument.markupOptions.userDoctype == "-//ACME//DTD HTML 3.14159//EN")
        XCTAssert(tidyDocument.markupOptions.doctype == .user)
        
        // It is possible to do dumb things like set the user doctype to "" or nil,
        // and the doctype mode will still be changed to `user`. (That is Tidy's fault, though.)
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        tidyDocument.markupOptions.doctype = .auto
        tidyDocument.markupOptions.userDoctype = ""
        XCTAssert(tidyDocument.markupOptions.userDoctype == nil)
        XCTAssert(tidyDocument.markupOptions.doctype == .user)
        
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        tidyDocument.markupOptions.doctype = .auto
        tidyDocument.markupOptions.userDoctype = nil
        XCTAssert(tidyDocument.markupOptions.userDoctype == nil)
        XCTAssert(tidyDocument.markupOptions.doctype == .user)
        
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        tidyDocument.markupOptions.doctype = .auto
        tidyDocument.markupOptions.userDoctype = "\""
        XCTAssert(tidyDocument.markupOptions.userDoctype == nil)
        XCTAssert(tidyDocument.markupOptions.doctype == .user)
        
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        tidyDocument.markupOptions.doctype = .auto
        tidyDocument.markupOptions.userDoctype = "\"\""
        XCTAssert(tidyDocument.markupOptions.userDoctype == nil)
        XCTAssert(tidyDocument.markupOptions.doctype == .user)
        
        // Tidy will change the doctype mode to `user` even if the
        // user doctype is unchanged:
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        tidyDocument.markupOptions.doctype = .auto
        tidyDocument.markupOptions.userDoctype = "-//ACME//DTD HTML 3.14159//EN"
        XCTAssert(tidyDocument.markupOptions.userDoctype == "-//ACME//DTD HTML 3.14159//EN")
        XCTAssert(tidyDocument.markupOptions.doctype == .user)
        
    }
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
        
        
    }
    
}
