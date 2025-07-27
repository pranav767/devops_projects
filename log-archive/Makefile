# Makefile for Log Archive Tool

# Variables
SCRIPT_NAME = log-archive
INSTALL_DIR = /usr/local/bin
TEST_DIR = test_logs

# Default target
.PHONY: all
all: help

# Display help information
.PHONY: help
help:
	@echo "Log Archive Tool - Available targets:"
	@echo ""
	@echo "  install     - Install the script to $(INSTALL_DIR)"
	@echo "  uninstall   - Remove the script from $(INSTALL_DIR)"
	@echo "  test        - Run tests with sample log files"
	@echo "  clean       - Remove test files and archives"
	@echo "  setup-test  - Create test log files"
	@echo "  demo        - Run a complete demonstration"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  make install          # Install system-wide"
	@echo "  make test            # Run tests"
	@echo "  make demo            # Full demonstration"

# Install the script system-wide
.PHONY: install
install:
	@echo "Installing $(SCRIPT_NAME) to $(INSTALL_DIR)..."
	@sudo cp $(SCRIPT_NAME) $(INSTALL_DIR)/
	@sudo chmod +x $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Installation completed. You can now run 'log-archive' from anywhere."

# Uninstall the script
.PHONY: uninstall
uninstall:
	@echo "Removing $(SCRIPT_NAME) from $(INSTALL_DIR)..."
	@sudo rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Uninstallation completed."

# Create test log files
.PHONY: setup-test
setup-test:
	@echo "Creating test log directory and sample files..."
	@mkdir -p $(TEST_DIR)
	@echo "2024-07-27 10:00:01 [INFO] Application started" > $(TEST_DIR)/app.log
	@echo "2024-07-27 10:01:15 [ERROR] Database connection failed" >> $(TEST_DIR)/app.log
	@echo "2024-07-27 10:02:30 [INFO] Retrying database connection" >> $(TEST_DIR)/app.log
	@echo "127.0.0.1 - - [27/Jul/2024:10:00:00 +0000] \"GET / HTTP/1.1\" 200 1234" > $(TEST_DIR)/access.log
	@echo "127.0.0.1 - - [27/Jul/2024:10:01:00 +0000] \"GET /api/users HTTP/1.1\" 200 567" >> $(TEST_DIR)/access.log
	@echo "192.168.1.100 - - [27/Jul/2024:10:02:00 +0000] \"POST /api/login HTTP/1.1\" 401 89" >> $(TEST_DIR)/access.log
	@echo "2024-07-27 09:59:45 [DEBUG] Starting system monitor" > $(TEST_DIR)/system.log
	@echo "2024-07-27 10:00:12 [WARN] High memory usage detected: 85%" >> $(TEST_DIR)/system.log
	@echo "2024-07-27 10:01:33 [ERROR] Disk space low on /var partition" >> $(TEST_DIR)/system.log
	@echo "Test log files created in $(TEST_DIR)/"
	@ls -la $(TEST_DIR)/

# Run basic tests
.PHONY: test
test: setup-test
	@echo "Running log archive tests..."
	@echo "Testing help functionality:"
	@./$(SCRIPT_NAME) --help
	@echo ""
	@echo "Testing with invalid directory:"
	@./$(SCRIPT_NAME) /nonexistent/directory || true
	@echo ""
	@echo "Testing with empty directory:"
	@mkdir -p empty_test_dir
	@./$(SCRIPT_NAME) empty_test_dir || true
	@rmdir empty_test_dir
	@echo ""
	@echo "Testing archive creation (without removing originals):"
	@echo "no" | ./$(SCRIPT_NAME) $(TEST_DIR)
	@echo ""
	@echo "Verifying archive contents:"
	@ls -la $(TEST_DIR)/archives/
	@echo "Archive contents:"
	@tar -tzf $(TEST_DIR)/archives/logs_archive_*.tar.gz
	@echo ""
	@echo "Test completed successfully!"

# Run a complete demonstration
.PHONY: demo
demo: clean setup-test
	@echo "========================================"
	@echo "    LOG ARCHIVE TOOL DEMONSTRATION      "
	@echo "========================================"
	@echo ""
	@echo "1. Showing help:"
	@./$(SCRIPT_NAME) --help
	@echo ""
	@echo "2. Created test files:"
	@ls -la $(TEST_DIR)/
	@echo ""
	@echo "3. Contents of test files:"
	@echo "--- app.log ---"
	@cat $(TEST_DIR)/app.log
	@echo ""
	@echo "--- access.log ---"
	@cat $(TEST_DIR)/access.log
	@echo ""
	@echo "--- system.log ---"
	@cat $(TEST_DIR)/system.log
	@echo ""
	@echo "4. Running log archiver (preserving originals):"
	@echo "no" | ./$(SCRIPT_NAME) $(TEST_DIR)
	@echo ""
	@echo "5. Archive results:"
	@ls -la $(TEST_DIR)/archives/
	@echo ""
	@echo "6. Archive log:"
	@cat $(TEST_DIR)/archives/archive.log
	@echo ""
	@echo "7. Archive contents:"
	@tar -tzf $(TEST_DIR)/archives/logs_archive_*.tar.gz
	@echo ""
	@echo "========================================"
	@echo "       DEMONSTRATION COMPLETED          "
	@echo "========================================"

# Clean up test files
.PHONY: clean
clean:
	@echo "Cleaning up test files..."
	@rm -rf $(TEST_DIR)
	@rm -rf empty_test_dir
	@echo "Cleanup completed."

# Check if script is executable
.PHONY: check
check:
	@if [ -x $(SCRIPT_NAME) ]; then \
		echo "✓ $(SCRIPT_NAME) is executable"; \
	else \
		echo "✗ $(SCRIPT_NAME) is not executable. Run: chmod +x $(SCRIPT_NAME)"; \
	fi
	@if command -v tar >/dev/null 2>&1; then \
		echo "✓ tar command is available"; \
	else \
		echo "✗ tar command not found"; \
	fi
