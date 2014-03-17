#!/bin/sh

S=$1

echo Socket is $S >&2

(
B=$(echo -en '<html>Sample html</html>')
echo -en "HTTP/1.0 200 OK\nContent-Type: text/html\nContent-Length: ${#B}\n\n$B"
) >&$S

echo Served >&2
