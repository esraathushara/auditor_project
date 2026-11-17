#!/bin/bash
log_info() {
echo "[INFO] $1"
}
log_error() {
echo "[ERROR] $1"
}
log_action() {
echo "$(date) : $1" >> auditor.log
}
require_dir() {
if [ ! -d "$1" ]
then
log_error "Directory does not exist"
exit 1
fi
}
