import Foundation

struct CronJobSchedule {
    enum ScheduleDay: String {
        case today, tomorrow
    }
    
    let hour: Int
    let minute: Int
    let day: ScheduleDay
    let command: String
}
