import Foundation

final class CronJobManager {
    private let jobs: [CronJob]
    
    init(jobs: [CronJob]) {
        self.jobs = jobs
    }
    
    func schedules(withTime: Time) -> [CronJobSchedule] {
        jobs.map({ nextSchedule(for: $0, withTime: time) })
    }
    
    func nextSchedule(for cronJob: CronJob, withTime time: Time) -> CronJobSchedule {
        var runDay = CronJobSchedule.ScheduleDay.today
        
        var nextRunTime = Time(
            hour: cronJob.hour ?? time.hour,
            minute: cronJob.minute ?? time.minute
        )
        
        if nextRunTime < time {
            if cronJob.hour == nil {
                nextRunTime.hour += 1
                if nextRunTime.hour > 23 {
                    nextRunTime.hour = 0
                    runDay = .tomorrow
                }
            } else {
                runDay = .tomorrow
            }
            
            if cronJob.minute == nil {
                if time.hour > nextRunTime.hour {
                    nextRunTime.minute = 0
                }
            }
        } else {
            if cronJob.minute == nil {
                if time.hour < nextRunTime.hour {
                    nextRunTime.minute = 0
                }
            }
        }
        
        return CronJobSchedule(
            hour: nextRunTime.hour,
            minute: nextRunTime.minute,
            day: runDay,
            command: cronJob.command
        )
    }
}
