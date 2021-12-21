# cron-parser

A sample Swift CLI application for parsing simplified crojobs and calculating when the next job should run.

**Sample input**

```
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
```

## Usage

It's best to run the application from the command line. I can be both compiled and executed quite easily.

```bash
swift build
cat sample.txt | .build/debug/cron-parser 10:30
```
