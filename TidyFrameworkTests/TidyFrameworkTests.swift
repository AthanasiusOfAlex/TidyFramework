//
//  TidyFrameworkTests.swift
//  TidyFrameworkTests
//
//  Created by Louis Melahn on 8/31/16.
//  Copyright © 2016 Louis Melahn. All rights reserved.
//

import XCTest
@testable import TidyFramework

class TidyFrameworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // TEST- testTidy should return a value that is > 0. Otherwise the tidy library
        XCTAssert(testTidy()>0, "Something is wrong with the Tidy library, because an error has occurred.")
        
        let tidyDocument = TidyDocument()
        XCTAssert(tidyDocument.markupOptions.anchorAsName==YesNo.yes)
        XCTAssert(tidyDocument.characterEncodingOptions.charEncoding==CharacterEncoding.utf8)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
        
       
    }
    
}
