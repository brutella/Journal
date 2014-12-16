//
//  LoggerTest.swift
//  Squares
//
//  Created by Matthias Hochgatterer on 04/12/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

import UIKit
import XCTest

class TestOutput: Output {
    var processed: [String]
    init(){
        processed = [String]()
    }
    
    func process(string: String) {
        processed.append(string)
    }
}

class LoggerTest: XCTestCase {
    var logger: Logger!
    override func setUp() {
        super.setUp()
        logger = Logger()
    }

    func testLog() {
        let test = TestOutput()
        logger.addOutput(test)
        logger.log("First log message")
        XCTAssertEqual(test.processed.count, 1)
        let string = test.processed[0]
        XCTAssertTrue(string == "First log message")
    }
    
    func testAsyncLogging() {
        let test = TestOutput()
        logger.addOutput(test)
        
        let expectionation = expectationWithDescription("logged")
        dispatch_async(dispatch_get_main_queue(), {
            self.logger.log("Second log message")
            expectionation.fulfill()
        })
        
        logger.log("First log message")
        self.waitForExpectationsWithTimeout(0.1) {
            error in
            XCTAssertEqual(test.processed.count, 2)
            XCTAssertTrue(test.processed[0] == "First log message")
            XCTAssertTrue(test.processed[1] == "Second log message")
        }
    }
    
    func testFileLogger() {
        let filePath = NSTemporaryDirectory().stringByAppendingPathComponent("\(NSDate().timeIntervalSinceReferenceDate).log")
        let fileLogger = FileOutput(filePath: filePath)
        logger.addOutput(fileLogger)
        
        logger.log("First log message")
        logger.log("Second log message")
        var error: NSError?
        if let string = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: &error) {
            XCTAssertNil(error)
            XCTAssertEqual(string, "First log message\nSecond log message\n")
        } else {
            XCTFail("\(error)")
        }
    }

    func testPerformanceFileOutput() {
        let filePath = NSTemporaryDirectory().stringByAppendingPathComponent("test.log")
        let fileLogger = FileOutput(filePath: filePath)
        logger.addOutput(fileLogger)
        self.measureBlock() {
            self.logger.log("This is a logged test string")
        }
    }
    
    func testPerformanceSwiftPrintln() {
        self.measureBlock() {
            Swift.println("This is a logged test string")
        }
    }
}
