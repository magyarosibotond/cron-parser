enum CronJobParserError: Error {
    case invalidFormat(String)
    case invalidTimeComponentFormat(String)
    case invalidTimeComponentRange(String, ClosedRange<Int>)
}

func cronJobParser(_ rawInput: String) throws -> CronJob? {
    let components = rawInput.split(separator: " ", maxSplits: 2)
    guard components.count == 3, let command = components.last.map({ String($0) }) else {
        throw CronJobParserError.invalidFormat(rawInput)
    }
    
    let hour = try parseCronTimeComponent(String(components[1]), range: 0...23)
    let minute = try parseCronTimeComponent(String(components[0]), range: 0...59)
    
    return CronJob(hour: hour, minute: minute, command: command)
}

private func parseCronTimeComponent(_ input: String, range: ClosedRange<Int>) throws -> Int? {
    guard input != "*" else { return nil }
    guard let intValue = Int(input) else {
        throw CronJobParserError.invalidTimeComponentFormat(input)
    }
    guard range.contains(intValue) else {
        throw CronJobParserError.invalidTimeComponentRange(input, range)
    }
    return intValue
}
