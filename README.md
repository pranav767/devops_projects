# DevOps Projects Collection

This repository contains practical DevOps tools and scripts for Linux system administration and monitoring.

## Projects Included

### 1. 🗂️ Log Archive Tool (`log-archive`)
A comprehensive command-line tool for archiving log files with compression and timestamping.

**Features:**
- Compresses logs into timestamped tar.gz archives
- Automatic archive directory creation
- Comprehensive logging of operations
- Optional removal of original files
- Colored console output
- Input validation and error handling

**Usage:**
```bash
./log-archive <log-directory>
./log-archive /var/log
./log-archive /home/user/app/logs
```

### 2. 📊 Server Stats Script (`server-stats.sh`)
A shell script that analyzes basic server performance statistics on Linux systems.

**Features:**
- Total CPU usage monitoring
- Memory usage analysis (Free vs Used with percentages)
- Disk usage statistics (Free vs Used with percentages)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- Additional system information

**Usage:**
```bash
./server-stats.sh
```

## Project Structure

```
devops_projects/
├── README.md                    # This file
├── README_log_archive.md        # Detailed log archive documentation
├── log-archive                  # Log archive tool (executable)
├── log-archive.cron            # Sample cron configuration
├── server-stats.sh             # Server monitoring script
├── Makefile                    # Build and test automation
└── test_logs/                  # Test directory for demonstrations
    └── archives/               # Generated archives directory
```

## Quick Start

### Log Archive Tool
```bash
# Make executable
chmod +x log-archive

# Test with sample data
make demo

# Install system-wide
make install

# Archive system logs
log-archive /var/log
```

### Server Stats Tool
```bash
# Make executable
chmod +x server-stats.sh

# Run system analysis
./server-stats.sh
```

## Automation

### Automated Log Archiving
Use the provided cron configuration for automated log archiving:

```bash
# Copy cron configuration
sudo cp log-archive.cron /etc/cron.d/

# Or add to user crontab
crontab -e
# Add: 0 2 * * * /usr/local/bin/log-archive /var/log >/dev/null 2>&1
```

### Scheduled System Monitoring
Add server stats to cron for regular monitoring:

```bash
# Run system stats daily at 6 AM and save to file
0 6 * * * /path/to/server-stats.sh >> /var/log/system-stats.log 2>&1
```

## Available Make Targets

```bash
make help         # Show available commands
make install      # Install log-archive system-wide
make uninstall    # Remove log-archive from system
make test         # Run comprehensive tests
make demo         # Run complete demonstration
make clean        # Clean up test files
make setup-test   # Create test log files only
```

## Requirements

- Bash shell
- Standard Unix utilities (tar, find, awk, etc.)
- Appropriate permissions for target directories

## Use Cases

### Log Archive Tool
- **System Administration**: Archive old system logs to save disk space
- **Application Maintenance**: Compress application logs before log rotation
- **Compliance**: Maintain compressed logs for auditing purposes
- **Backup Strategy**: Create compressed backups of log data

### Server Stats Tool
- **Performance Monitoring**: Regular system health checks
- **Troubleshooting**: Quick system overview during issues
- **Capacity Planning**: Monitor resource usage trends
- **Documentation**: Generate system reports

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Best Practices

### For Log Archiving
- Run during off-peak hours
- Monitor disk space before archiving
- Test restore procedures regularly
- Document retention policies

### For System Monitoring
- Set up alerting for critical thresholds
- Archive monitoring data regularly
- Create baseline measurements
- Monitor trends over time

## License

This project is open source and available under the MIT License.

## Support

For issues, feature requests, or questions:
1. Check the documentation in each tool's section
2. Review the troubleshooting guides
3. Create an issue in the repository
4. Consult the system logs for detailed error information