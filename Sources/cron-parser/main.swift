// Parse CLI arguments

import Darwin

let time: Time
var cronJobs: [CronJob] = []

guard CommandLine.arguments.count >= 2 else {
    print("""
Please provide an hour command line argument:
cron.parser 10:30
""")
    exit(1)
}

do {
    time = try timeParser(CommandLine.arguments[1])
} catch {
    print("Invalid argument format. It should be a hour string: 10:30")
    exit(1)
}

// Read data from stdin

while let line = readLine(), !line.isEmpty {
    do {
        cronJobs.append(try cronJobParser(line))
    } catch {
        print(error)
    }
}

let manager = CronJobManager(jobs: cronJobs)
let schedules = manager.schedules(withTime: time)

// Print results

for schedule in schedules {
    print(String(format: "%d:%02d %@ - %@", schedule.hour, schedule.minute, schedule.day.rawValue, schedule.command))
}
