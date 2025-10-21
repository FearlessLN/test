#!/bin/bash

PROCESS_NAME="test"
API_URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
STATE_FILE="/var/run/monitor_test.state"
TIMEOUT=10

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

PID=$(pgrep -x "$PROCESS_NAME")

if [ -z "$PID" ]; then
    exit 0
fi

PREV_PID=""
if [ -f "$STATE_FILE" ]; then
    PREV_PID=$(cat "$STATE_FILE")
fi

if [ -n "$PREV_PID" ] && [ "$PID" != "$PREV_PID" ]; then
    log_message "Process '$PROCESS_NAME' was restarted (old PID: $PREV_PID, new PID: $PID)"
fi

echo "$PID" > "$STATE_FILE"

if ! curl -f -s -S --max-time "$TIMEOUT" "$API_URL" > /dev/null 2>&1; then
    log_message "Server unavailable (URL: $API_URL)"
fi

exit 0
