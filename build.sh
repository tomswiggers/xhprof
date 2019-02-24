#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo "This script uses functionality which requires root privileges"
    exit 1
fi

# Start the build with an empty ACI
acbuild --debug begin

# In the event of the script exiting, end the build
acbuildEnd() {
    export EXIT=$?
    acbuild --debug end && exit $EXIT
}
trap acbuildEnd EXIT

# Name the ACI
acbuild --debug set-name xhprof

# Based on alpine
acbuild --debug dep add quay.io/coreos/alpine-sh

# Install PHP/apache
acbuild --debug run apk update
acbuild --debug run apk add apache2
acbuild --debug run apk add php
acbuild --debug run apk add php-ctype
acbuild --debug run apk add php-gd
acbuild --debug run apk add php-apache2
acbuild --debug run apk add graphviz
acbuild --debug run apk add ttf-dejavu

# Add a port for http traffic over port 80
acbuild --debug port add http tcp 80

# Add a mount point for files to serve
acbuild --debug mount add localhost /var/www/localhost

acbuild --debug set-exec -- /usr/sbin/httpd -DFOREGROUND
#acbuild --debug set-exec -- /bin/sh

# Save the ACI
acbuild --debug write --overwrite xhprof.aci
