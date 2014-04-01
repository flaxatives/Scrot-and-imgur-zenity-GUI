#!/bin/bash

# Zenity messages by Christian Zucchelli (@Chris_Zeta) <thewebcha@gmail.com>

# sftp script provided by Marc Evangelista

# Required: sftp
#
# Optional: xsel or xclip for automatically putting the URLs on the X selection
# for easy pasting
#
# Instructions:

# function to output usage instructions
function usage {
echo "Usage: $(basename $0) <filename> [<filename> [...]]" >&2
echo "Upload images to imgur and output their new URLs to stdout. Each one's" >&2
echo "delete page is output to stderr between the view URLs." >&2
echo "If xsel or xclip is available, the URLs are put on the X selection for" >&2
echo "easy pasting." >&2
}

# vars.sh much set variables
# base url needs backslash
# BASEURL=http://example.com/screenshots/   
source $HOME/.zscreen/vars.sh

# check arguments
if [ "$1" = "-h" -o "$1" = "--help" ]; then
usage
exit 0
elif [ $# == 0 ]; then
echo "No file specified" >&2
usage
exit 16
fi

# check curl is available
type sftp >/dev/null 2>/dev/null || {
echo "Couln't find sftp, which is required." >&2
exit 17
}

clip=""
errors=false

# loop through arguments
while [ $# -gt 0 ]; do
file="$1"
shift

# check file exists
#if [ ! -f "$file" ]; then
#zenity --info --text "file '$file' doesn't exist, skipping" >&2
#errors=true
#continue
#fi

# upload the image
response=$($HOME/.zscreen/sftp.sh $file)
# the "Expect: " header is to get around a problem when using this through
# the Squid proxy. Not sure if it's a Squid bug or what.
if [ $? -ne 0 ]; then
zenity --info --text "Upload failed" >&2
errors=true
continue
fi


# append the URL to a string so we can put them all on the clipboard later
clip="$BASEURL$(basename $file)"
done

# put the URLs on the clipboard if we have xsel or xclip
if [ $DISPLAY ]; then
{ type xsel >/dev/null 2>/dev/null && echo -n $clip | xsel; } \
|| { type xclip >/dev/null 2>/dev/null && echo -n $clip | xclip; } \
|| echo "Haven't copied to the clipboard: no xsel or xclip" >&2
else
echo "Haven't copied to the clipboard: no \$DISPLAY" >&2
fi

if $errors; then
exit 1
fi
