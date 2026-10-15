#!/bin/bash
while true ; do echo "beacon" | nc 192.168.56.103 4444; sleep 10; done
