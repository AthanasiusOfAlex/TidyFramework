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
        
        // TEST - These are the defaults that should be read in a new Tidy Document.
        let tidyDocument = TidyDocument()
        XCTAssert(tidyDocument.miscellaneousOptions.writeBack == YesNo.no)
        XCTAssert(tidyDocument.miscellaneousOptions.errorFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.gnuEmacsFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.keepTime == YesNo.no)
        XCTAssert(tidyDocument.miscellaneousOptions.quiet == YesNo.no)
        XCTAssert(tidyDocument.miscellaneousOptions.gnuEmacs == YesNo.no)
        XCTAssert(tidyDocument.miscellaneousOptions.tidyMark == YesNo.yes)
        XCTAssert(tidyDocument.miscellaneousOptions.outputFile == nil)
        XCTAssert(tidyDocument.miscellaneousOptions.forceOutput == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.outputXml == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.joinClasses == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.encloseText == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.indentCdata == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.mergeSpans == TriState.auto)
        XCTAssert(tidyDocument.markupOptions.fixBackslash == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.clean == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.doctype == DocType.auto)
        XCTAssert(tidyDocument.markupOptions.dropProprietaryAttributes == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.uppercaseTags == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.quoteMarks == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.cssPrefix == nil)
        XCTAssert(tidyDocument.markupOptions.userDoctype == nil)
        XCTAssert(tidyDocument.markupOptions.outputHtml == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.joinStyles == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.decorateInferredUl == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.newPreTags == nil)
        XCTAssert(tidyDocument.markupOptions.altText == nil)
        XCTAssert(tidyDocument.markupOptions.lowerLiterals == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.coerceEndtags == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.newInlineTags == nil)
        XCTAssert(tidyDocument.markupOptions.literalAttributes == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.anchorAsName == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.addXmlSpace == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.inputXml == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.skipNested == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.dropEmptyParas == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.replaceColor == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.mergeEmphasis == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.addXmlDecl == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.bare == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.hideEndtags == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.outputXhtml == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.uppercaseAttributes == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.newEmptyTags == nil)
        XCTAssert(tidyDocument.markupOptions.preserveEntities == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.numericEntities == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.dropFontTags == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.quoteNbsp == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.dropEmptyElements == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.logicalEmphasis == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.omitOptionalTags == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.encloseBlockText == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.escapeCdata == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.showBodyOnly == TriState.no)
        XCTAssert(tidyDocument.markupOptions.mergeDivs == TriState.auto)
        XCTAssert(tidyDocument.markupOptions.gdoc == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.word2000 == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.repeatedAttributes == RepeatedAttributeModes.keepLast)
        XCTAssert(tidyDocument.markupOptions.quoteAmpersand == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.fixBadComments == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.strictTagsAttributes == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.newBlocklevelTags == nil)
        XCTAssert(tidyDocument.markupOptions.fixUri == YesNo.yes)
        XCTAssert(tidyDocument.markupOptions.assumeXmlProcins == YesNo.no)
        XCTAssert(tidyDocument.markupOptions.hideComments == YesNo.no)
        XCTAssert(tidyDocument.prettyPrintOptions.indentSpaces == 2)
        XCTAssert(tidyDocument.prettyPrintOptions.escapeScripts == YesNo.yes)
        XCTAssert(tidyDocument.prettyPrintOptions.indentWithTabs == YesNo.no)
        XCTAssert(tidyDocument.prettyPrintOptions.tabSize == 8)
        XCTAssert(tidyDocument.prettyPrintOptions.wrap == 68)
        XCTAssert(tidyDocument.prettyPrintOptions.indent == TriState.no)
        XCTAssert(tidyDocument.prettyPrintOptions.verticalSpace == TriState.no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapSections == YesNo.yes)
        XCTAssert(tidyDocument.prettyPrintOptions.markup == YesNo.yes)
        XCTAssert(tidyDocument.prettyPrintOptions.sortAttributes == AttributeSortStrategy.none)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapAttributes == YesNo.no)
        XCTAssert(tidyDocument.prettyPrintOptions.indentAttributes == YesNo.no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapJste == YesNo.yes)
        XCTAssert(tidyDocument.prettyPrintOptions.breakBeforeBr == YesNo.no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapPhp == YesNo.yes)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapScriptLiterals == YesNo.no)
        XCTAssert(tidyDocument.prettyPrintOptions.wrapAsp == YesNo.yes)
        XCTAssert(tidyDocument.diagnosticsOptions.showInfo == YesNo.yes)
        XCTAssert(tidyDocument.diagnosticsOptions.showWarnings == YesNo.yes)
        XCTAssert(tidyDocument.diagnosticsOptions.showErrors == 6)
        XCTAssert(tidyDocument.diagnosticsOptions.accessibilityCheck == AccessibilityCheckLevel.classic)
        XCTAssert(tidyDocument.characterEncodingOptions.charEncoding == CharacterEncoding.utf8)
        XCTAssert(tidyDocument.characterEncodingOptions.outputEncoding == CharacterEncoding.utf8)
        XCTAssert(tidyDocument.characterEncodingOptions.asciiChars == YesNo.no)
        XCTAssert(tidyDocument.characterEncodingOptions.newline == NewlineType.LF)
        XCTAssert(tidyDocument.characterEncodingOptions.inputEncoding == CharacterEncoding.utf8)
        
        /*** Uncomment the following lines to generate the test code
         func generateTestCode() {
         print("===============================")
         print("List of Options")
         print("===============================")
         
         for child in Mirror(reflecting: tidyDocument).children.filter({ $0.value is TidyOptions })  {
         
         let optionGroup = child.value
         let optionGroupName = child.label!
         
         for child in Mirror(reflecting: optionGroup).children {
         
         let optionName = child.label!
         let option = child.value
         
         let typePrefix: String
         
         switch option {
         
         case is String, is Int:
         typePrefix = ""
         
         default:
         typePrefix = "\(option.dynamicType)."
         
         }
         
         print("XCTAssert(tidyDocument.\(optionGroupName).\(optionName) == \(typePrefix)\(option))")
         
         }
         
         }
         
         print("===============================")
         }
         
         generateTestCode()
         ***/
        
    }
    
    func testSettingOptions() {
        
        // Some tests to make sure that setting options works
        
        let tidyDocument = TidyDocument()
        
        tidyDocument.prettyPrintOptions.indentSpaces = 234
        XCTAssert(tidyDocument.prettyPrintOptions.indentSpaces==234)
        
        tidyDocument.miscellaneousOptions.errorFile = "foobar"
        XCTAssert(tidyDocument.miscellaneousOptions.errorFile=="foobar")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
        
        
    }
    
}
