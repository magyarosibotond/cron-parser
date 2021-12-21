import XCTest
@testable import cron_parser

class cronJobParserTests: XCTestCase {

    func testRunAtSpecificHourMinute() {
        let rawInput = "30 11 /run_me"
        
        let cronjob = try! cronJobParser(rawInput)
        
        XCTAssertEqual(cronjob, CronJob(hour: 11, minute: 30, command: "/run_me"))
    }
    
    func testWildcardHour() {
        let rawInput = "30 * /run_me"
        
        let cronjob = try! cronJobParser(rawInput)
        
        XCTAssertEqual(cronjob, CronJob(hour: nil, minute: 30, command: "/run_me"))
    }
    
    func testWildcardMinute() {
        let rawInput = "* 10 /run_me"
        
        let cronjob = try! cronJobParser(rawInput)
        
        XCTAssertEqual(cronjob, CronJob(hour: 10, minute: nil, command: "/run_me"))
    }
    
    func testWildcardHourAndMinute() {
        let rawInput = "* * /run_me"
        
        let cronjob = try! cronJobParser(rawInput)
        
        XCTAssertEqual(cronjob, CronJob(hour: nil, minute: nil, command: "/run_me"))
    }
}
