//
//  timeParserTests.swift
//  
//
//  Created by Botond Magyarosi on 21.12.2021.
//

import XCTest
@testable import cron_parser

class timeParserTests: XCTestCase {

    func testValidTime() {
        let rawInput = "10:30"
        
        let time = try! timeParser(rawInput)
        
        XCTAssertEqual(time, Time(hour: 10, minute: 30))
    }
    
    func testInvalidTime() {
        let rawInput = "100"
        
        do {
            _ = try timeParser(rawInput)
            XCTFail("\(rawInput) should not be parsable.")
        } catch { }
    }
    
    func testInvalidTimeInvalidHourComponent() {
        let rawInput = "50:30"
        
        do {
            _ = try timeParser(rawInput)
            XCTFail("\(rawInput) should not be parsable.")
        } catch { }
    }
}
