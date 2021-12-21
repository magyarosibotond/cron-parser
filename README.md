# cron-parser

A sample Swift CLI application for parsing simplified crojobs and calculating when the next job should run.

No dependencies were used, not even Apple Swift frameworks that help with command line scripts (ArgumentParser, etc ...).

**Sample input**

```
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
```

Should return the following result using 16:10 as a parameter.

```
1:30 tomorrow - /bin/run_me_daily
16:45 today - /bin/run_me_hourly
16:10 today - /bin/run_me_every_minute
19:00 today - /bin/run_me_sixty_times
```

## Usage

It's best to run the application from the command line. I can be both compiled and executed quite easily.

```bash
swift build
cat sample.txt | .build/debug/cron-parser 10:30
```
