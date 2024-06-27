#!/bin/bash

# check pip3
if command -v pip3 &> /dev/null; then
    echo "python3-pip is installed"
else
    echo "python3-pip not found! Installing..."
    sudo apt-get update
    sudo apt-get install -y python3-pip
    if [ $? -eq 0 ]; then
        echo "python3-pip is installed and working correctly."
    else
        echo "Failed to install python3-pip" >&2
    fi
fi

# check libaio-dev
dpkg -s libaio-dev &> /dev/null
if [ $? -eq 0 ]; then
    echo "libaio-dev is installed"
else
    echo "libaio-dev not found! Installing..."
    sudo apt-get update
    sudo apt-get install -y libaio-dev
    if [ $? -eq 0 ]; then
        echo "libaio-dev is installed and working correctly."
    else
        echo "Failed to install libaio-dev" >&2
    fi
fi
echo "Finish."
exit 0
