# Log Archive Tool

A command-line tool for archiving log files by compressing them into timestamped tar.gz files. This tool helps maintain system cleanliness by archiving old logs while preserving them for future reference.

## Features

- ✅ Compress logs into timestamped tar.gz archives
- ✅ Automatic archive directory creation
- ✅ Comprehensive logging of archive operations
- ✅ Colored console output for better readability
- ✅ Optional removal of original files after archiving
- ✅ Input validation and error handling
- ✅ Archive summary with file counts and sizes
- ✅ Support for any log directory location

## Installation

1. Clone or download the `log-archive` script
2. Make it executable:
   ```bash
   chmod +x log-archive
   ```
3. Optionally, move it to a directory in your PATH for system-wide access:
   ```bash
   sudo mv log-archive /usr/local/bin/
   ```

## Usage

### Basic Usage
```bash
./log-archive <log-directory>
```

### Examples
```bash
# Archive system logs
./log-archive /var/log

# Archive application logs
./log-archive /home/user/app/logs

# Archive logs in current directory
./log-archive ./logs
```

### Help
```bash
./log-archive --help
```

## How It Works

1. **Validation**: Checks if the specified log directory exists and is readable
2. **Archive Directory**: Creates an `archives` subdirectory within the log directory
3. **Compression**: Creates a timestamped tar.gz file containing all log files
4. **Logging**: Records the operation in `archives/archive.log`
5. **Cleanup**: Optionally removes original files after successful archiving

## Archive Naming Convention

Archives are named using the following format:
```
logs_archive_YYYYMMDD_HHMMSS.tar.gz
```

Example: `logs_archive_20240816_100648.tar.gz`

## Output Structure

```
log-directory/
├── archives/
│   ├── logs_archive_20240816_100648.tar.gz
│   ├── logs_archive_20240817_143022.tar.gz
│   └── archive.log
└── [original log files - optionally removed]
```

## Archive Log Format

The tool maintains a log of all archiving operations in `archives/archive.log`:

```
[2024-08-16 10:06:48] Archive created: logs_archive_20240816_100648.tar.gz | Size: 1.2M | Files: 15 | Source: /var/log
```

## Features in Detail

### Colored Output
- 🔵 **INFO**: General information messages
- 🟢 **SUCCESS**: Successful operations
- 🟡 **WARNING**: Warning messages and confirmations
- 🔴 **ERROR**: Error messages

### Safety Features
- Input validation for directory existence and readability
- Confirmation prompt before removing original files
- Detailed error messages with suggested solutions
- Archive integrity verification

### Archive Summary
After successful archiving, the tool displays:
- Archive filename and location
- Archive size
- Number of files archived
- Creation timestamp

## Requirements

- Bash shell
- `tar` command (standard on Unix/Linux systems)
- `find` command
- `du` command
- Basic Unix utilities (`awk`, `wc`, `date`, etc.)

## Permissions

The tool requires:
- Read permissions on the source log directory
- Write permissions to create the archives subdirectory
- Execute permissions on the script file

For system log directories like `/var/log`, you may need to run with `sudo`:
```bash
sudo ./log-archive /var/log
```

## Error Handling

The tool handles various error conditions:
- Non-existent directories
- Permission issues
- Empty directories
- Archive creation failures
- Disk space issues

## Advanced Usage

### Automation with Cron

You can automate log archiving using cron jobs:

```bash
# Edit crontab
crontab -e

# Add entry to archive logs daily at 2 AM
0 2 * * * /usr/local/bin/log-archive /var/log >/dev/null 2>&1

# Archive application logs weekly on Sundays at 3 AM
0 3 * * 0 /usr/local/bin/log-archive /home/user/app/logs >/dev/null 2>&1
```

### Integration with Log Rotation

This tool complements standard log rotation tools like `logrotate`. Use it to archive rotated logs before they're deleted.

## Troubleshooting

### Common Issues

1. **Permission Denied**
   ```
   Solution: Run with appropriate permissions or sudo
   ```

2. **Directory Not Found**
   ```
   Solution: Verify the directory path is correct
   ```

3. **No Space Left on Device**
   ```
   Solution: Free up disk space or choose a different archive location
   ```

## Examples and Test Case

The project includes a test setup that demonstrates the tool's functionality:

1. Create test logs:
   ```bash
   mkdir test_logs
   echo "2024-07-27 10:00:01 [INFO] Application started" > test_logs/app.log
   echo "127.0.0.1 - - [27/Jul/2024:10:00:00 +0000] \"GET / HTTP/1.1\" 200 1234" > test_logs/access.log
   echo "2024-07-27 09:59:45 [DEBUG] Starting system monitor" > test_logs/system.log
   ```

2. Run the archiver:
   ```bash
   ./log-archive test_logs
   ```

3. Verify results:
   ```bash
   ls -la test_logs/archives/
   tar -tzf test_logs/archives/logs_archive_*.tar.gz
   ```

## Future Enhancements

Potential improvements for advanced versions:
- Email notifications after archiving
- Remote storage integration (AWS S3, FTP, etc.)
- Compression level options
- Exclude patterns for specific file types
- Retention policies for old archives
- Progress bars for large archives
- Multiple compression formats (zip, bzip2, etc.)

## Contributing

Feel free to submit issues, feature requests, or pull requests to improve this tool.

## License

This project is open source and available under the MIT License.
