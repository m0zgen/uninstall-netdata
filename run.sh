#!/bin/bash
# Run netdata uninstaller, wrapper script

# Sys env / paths / etc
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMP_PATH="${SCRIPT_PATH}/tmp"

cd $SCRIPT_PATH

# Check if netdata is installed
if [ ! -f /usr/sbin/netdata ]; then
    echo "Netdata is not installed!"
    exit 1
elif
    # Check if folder exists
    if [ ! -d "${TMP_PATH}" ]; then
        mkdir -p "${TMP_PATH}"
    fi
    cd "${TMP_PATH}"
    # Download uninstaller
    wget https://raw.githubusercontent.com/netdata/netdata/master/packaging/installer/netdata-uninstaller.sh
    # Set executable
    chmod +x netdata-uninstaller.sh
    # Run uninstaller
    ./netdata-uninstaller.sh --yes --force
    # Remove tmp folder
    # rm -rf "${TMP_PATH}"
    # Run apt autoremove
    apt autoremove -y

fi