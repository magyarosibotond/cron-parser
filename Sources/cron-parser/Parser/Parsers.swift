// MARK: - Error

enum CronJobParserError: Error {
    case invalidFormat(String)
}

enum TimeParserError: Error {
    case invalidFormat(String)
    case invalidTimeComponentFormat(String)
    case invalidTimeComponentRange(String, ClosedRange<Int>)
}

// MARK: - Parsers

private let hourRange = 0...23
private let minuteRange = 0...59

func timeParser(_ rawInput: String) throws -> Time {
    let components = rawInput.split(separator: ":", maxSplits: 1)
    guard components.count == 2 else {
        throw TimeParserError.invalidFormat(rawInput)
    }
    let hour = try parseInt(String(components[0]), range: hourRange)
    let minute = try parseInt(String(components[1]), range: minuteRange)
    return Time(hour: hour, minute: minute)
}

func cronJobParser(_ rawInput: String) throws -> CronJob {
    let components = rawInput.split(separator: " ", maxSplits: 2)
    guard components.count == 3, let command = components.last.map({ String($0) }) else {
        throw CronJobParserError.invalidFormat(rawInput)
    }
    let hour = try parseCronTimeComponent(String(components[1]), range: hourRange)
    let minute = try parseCronTimeComponent(String(components[0]), range: minuteRange)
    return CronJob(hour: hour, minute: minute, command: command)
}

// MARK: - Utility

private func parseCronTimeComponent(_ input: String, range: ClosedRange<Int>) throws -> Int? {
    guard input != "*" else { return nil }
    return try parseInt(input, range: range)
}

private func parseInt(_ input: String, range: ClosedRange<Int>) throws -> Int {
    guard let intValue = Int(input) else {
        throw TimeParserError.invalidTimeComponentFormat(input)
    }
    guard range.contains(intValue) else {
        throw TimeParserError.invalidTimeComponentRange(input, range)
    }
    return intValue
}
