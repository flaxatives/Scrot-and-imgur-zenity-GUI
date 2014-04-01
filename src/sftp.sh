#!/bin/bash

sftp sftpvilis <<EOF
put $1
bye
EOF
RESULT=$?
if [ $RESULT -ne 0 ]; then
    exit $RESULT
fi

echo $(basename $1)
exit 0
