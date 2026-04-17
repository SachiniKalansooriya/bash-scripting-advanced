# Advanced Bash Scripting

Advanced Bash automation scripts using loops, functions, arrays and conditionals on Ubuntu Linux 22.04. Built as part of my DevOps engineering learning journey.

## Environment
- OS: Ubuntu 22.04 on WSL2
- Shell: Bash
- Date: April 2026

## Scripts

### 1. system-health-report.sh
A comprehensive system health monitoring script that checks disk usage, RAM usage, and multiple service statuses in one run.

**Usage:**
```bash
./scripts/system-health-report.sh
```

**What it does:**
- Checks disk usage of root partition using df command
- Calculates RAM usage percentage using free command
- Loops through multiple services and checks each one
- Prints WARNING if disk or RAM is above 80%
- Saves a summary log entry with timestamp to logs/health-report.log

## Bash Concepts Used

### Variables
```bash
DATE=$(date '+%Y-%m-%d %H:%M:%S')   # Store command output
LOG="logs/health-report.log"         # Store a string value
```

### Arrays
```bash
SERVICES=("nginx" "cron" "systemd-resolved")   # Create an array
${SERVICES[@]}                                   # Access all items
${#SERVICES[@]}                                  # Count items in array
```

### Loops
```bash
for SERVICE in "${SERVICES[@]}"; do
    echo "Checking $SERVICE"
done
```

### Conditionals
```bash
if [ $DISK -gt 80 ]; then
    echo "WARNING"
else
    echo "OK"
fi
```

### Pipelines
```bash
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
```

### Bash Math
```bash
RAM_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))
```

### Log Writing
```bash
echo "[$DATE] message" >> logs/health-report.log
```

## Commands I Learned

| Command | What it does |
|---|---|
| df / | Show disk usage of root partition |
| df -h | Show disk usage in human readable format |
| free -h | Show RAM usage in human readable format |
| free | Show RAM usage in raw kilobytes |
| awk '{print $5}' | Print the 5th column of output |
| tr -d '%' | Remove % character from output |
| tail -1 | Take only the last line of output |
| grep Mem | Find lines containing Mem |
| systemctl is-active --quiet service | Silent service check for scripts |
| wc -l file | Count lines in a file |
| cat file | Print file contents |

## Bash Scripting Rules I Learned

| Rule | Example |
|---|---|
| First line must be shebang | #!/bin/bash |
| No spaces around = in variables | NAME="value" not NAME = "value" |
| Use $ to read variables | echo $NAME |
| Store command output with $() | DATE=$(date) |
| Spaces inside [ ] are mandatory | if [ $X -gt 5 ] |
| Use >> to append to log files | echo "text" >> file.log |
| Use > to overwrite files | echo "text" > file.log |
| Arrays use ( ) with spaces | ITEMS=("a" "b" "c") |
| Loop through array with [@] | for I in "${ITEMS[@]}"; do |
| Bash math uses $(( )) | RESULT=$((10 * 2)) |

## Log Files
- logs/health-report.log — System health check history with timestamps

## Skills Demonstrated
- Advanced Bash scripting with arrays and loops
- System resource monitoring — disk and RAM
- Service status checking with systemctl
- Pipeline commands combining df, awk, grep, tr
- Bash arithmetic for percentage calculation
- Structured logging with timestamps
- Git version control and GitHub
