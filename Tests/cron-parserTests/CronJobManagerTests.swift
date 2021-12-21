//
//  CronJobManagerTests.swift
//  
//
//  Created by Botond Magyarosi on 21.12.2021.
//

import XCTest
@testable import cron_parser

class CronJobManagerTests: XCTestCase {
    
    let manager = CronJobManager(jobs: [])

    // MARK: - Fixed cron
    
    func test_fixedCronJob_sameMoment() {
        validateCronJobResult(
            job: "30 10 test",
            time: Time(hour: 10, minute: 30),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_fixedCronJob_pastMoment() {
        validateCronJobResult(
            job: "30 10 test",
            time: Time(hour: 10, minute: 20),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_fixedCronJob_futureMoment() {
        validateCronJobResult(
            job: "30 10 test",
            time: Time(hour: 10, minute: 40),
            resHour: 10,
            resMinute: 30,
            resDay: .tomorrow
        )
    }
    
    // MARK: - Wildcard hour cron
    
    func test_wildcardHourCronJob_sameMoment() {
        validateCronJobResult(
            job: "30 * test",
            time: Time(hour: 10, minute: 30),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_wildcardHourCronJob_pastMoment() {
        validateCronJobResult(
            job: "30 * test",
            time: Time(hour: 10, minute: 20),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_wildcardHourCronJob_futureMoment() {
        validateCronJobResult(
            job: "30 * test",
            time: Time(hour: 10, minute: 40),
            resHour: 11,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_wildcardHourCronJob_futureMoment_carryOver() {
        validateCronJobResult(
            job: "30 * test",
            time: Time(hour: 23, minute: 40),
            resHour: 0,
            resMinute: 30,
            resDay: .tomorrow
        )
    }
    
    // MARK: - Wildcard minute cron
    
    func test_wildcardMinuteCronJob_pastMoment() {
        validateCronJobResult(
            job: "* 10 test",
            time: Time(hour: 9, minute: 30),
            resHour: 10,
            resMinute: 0,
            resDay: .today
        )
    }
    
    func test_wildcardMinuteCronJob_sameMoment() {
        validateCronJobResult(
            job: "* 10 test",
            time: Time(hour: 10, minute: 30),
            resHour: 10,
            resMinute: 30,
            resDay: .today
        )
    }
    
    func test_wildcardMinuteCronJob_futureMoment() {
        validateCronJobResult(
            job: "* 10 test",
            time: Time(hour: 11, minute: 40),
            resHour: 10,
            resMinute: 0,
            resDay: .tomorrow
        )
    }
    
    // MARK: - Wildcard cron
    
    func test_wildcardCronJob_anyMoment() {
        validateCronJobResult(
            job: "* * test",
            time: Time(hour: 10, minute: 20),
            resHour: 10,
            resMinute: 20,
            resDay: .today
        )
    }
    
    // MARK: - Utility
    
    private func validateCronJobResult(
        job: String,
        time: Time,
        resHour: Int,
        resMinute: Int,
        resDay: CronJobSchedule.ScheduleDay
    ) {
        let cronJob = try! cronJobParser(job)
        
        let schedule = manager.nextSchedule(for: cronJob, withTime: time)
        
        XCTAssertEqual(schedule.hour, resHour, "Hours not matching")
        XCTAssertEqual(schedule.minute, resMinute, "Minutes not matching")
        XCTAssertEqual(schedule.day, resDay, "Days not matching")
    }
}
