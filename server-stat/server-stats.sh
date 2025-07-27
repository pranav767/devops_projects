#!/bin/bash

# Server Stats Script
# Analyzes basic server performance statistics on Linux systems
# Author: System Monitor
# Date: $(date)

echo "========================================"
echo "        SERVER PERFORMANCE STATS        "
echo "========================================"
echo "Timestamp: $(date)"
echo "Hostname: $(hostname)"
echo "========================================"

# Function to print section headers
print_header() {
    echo ""
    echo "----------------------------------------"
    echo "$1"
    echo "----------------------------------------"
}

# 1. Total CPU Usage
print_header "CPU USAGE"
# Get CPU usage using top command (1 second sample)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F'%' '{print $1}')
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | awk -F'%' '{print $1}')
cpu_used=$(echo "100 - $cpu_idle" | bc -l 2>/dev/null || echo "scale=2; 100 - $cpu_idle" | bc)

echo "CPU Usage: ${cpu_used}%"
echo "CPU Idle: ${cpu_idle}%"

# Alternative method using vmstat
echo ""
echo "CPU Stats (vmstat):"
vmstat 1 2 | tail -1 | awk '{printf "User: %s%%, System: %s%%, Idle: %s%%, Wait: %s%%\n", $13, $14, $15, $16}'

# 2. Memory Usage
print_header "MEMORY USAGE"
# Get memory info from /proc/meminfo
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
mem_buffers=$(grep Buffers /proc/meminfo | awk '{print $2}')
mem_cached=$(grep "^Cached" /proc/meminfo | awk '{print $2}')

# Calculate used memory
mem_used=$((mem_total - mem_free - mem_buffers - mem_cached))

# Convert to MB and calculate percentages
mem_total_mb=$((mem_total / 1024))
mem_used_mb=$((mem_used / 1024))
mem_free_mb=$((mem_free / 1024))
mem_available_mb=$((mem_available / 1024))

mem_used_percent=$(echo "scale=2; $mem_used * 100 / $mem_total" | bc)
mem_free_percent=$(echo "scale=2; $mem_available * 100 / $mem_total" | bc)

echo "Total Memory: ${mem_total_mb} MB"
echo "Used Memory: ${mem_used_mb} MB (${mem_used_percent}%)"
echo "Available Memory: ${mem_available_mb} MB (${mem_free_percent}%)"
echo "Free Memory: ${mem_free_mb} MB"

# 3. Disk Usage
print_header "DISK USAGE"
echo "Filesystem Usage:"
df -h | head -1
df -h | grep -E "^/dev/" | while read filesystem size used avail percent mount; do
    echo "$filesystem $size $used $avail $percent $mount"
done

echo ""
echo "Disk Usage Summary:"
df -h --total | tail -1 | awk '{printf "Total: %s, Used: %s (%s), Available: %s\n", $2, $3, $5, $4}'

# 4. Top 5 Processes by CPU Usage
print_header "TOP 5 PROCESSES BY CPU USAGE"
echo "PID       USER      %CPU   %MEM   COMMAND"
ps aux --sort=-%cpu | head -6 | tail -5 | awk '{printf "%-8s  %-8s  %5s  %5s  %s\n", $2, $1, $3, $4, $11}'

# 5. Top 5 Processes by Memory Usage
print_header "TOP 5 PROCESSES BY MEMORY USAGE"
echo "PID       USER      %CPU   %MEM   COMMAND"
ps aux --sort=-%mem | head -6 | tail -5 | awk '{printf "%-8s  %-8s  %5s  %5s  %s\n", $2, $1, $3, $4, $11}'

# Additional System Information
print_header "ADDITIONAL SYSTEM INFO"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Uptime: $(uptime -p)"
echo "Number of processes: $(ps aux | wc -l)"
echo "Number of users logged in: $(who | wc -l)"

# Network connections (optional)
if command -v ss &> /dev/null; then
    echo "Active network connections: $(ss -tuln | wc -l)"
elif command -v netstat &> /dev/null; then
    echo "Active network connections: $(netstat -tuln | wc -l)"
fi

echo ""
echo "========================================"
echo "        END OF STATS REPORT             "
echo "========================================"
