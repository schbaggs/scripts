#!/bin/bash

if [ "$1" != "" ]; then

OUTPUT=$(gs -q  -o - -sDEVICE=inkcov "$1")

echo -n "total page number: "
echo "$OUTPUT" | wc -l

echo -n "b/w page number: "
echo "$OUTPUT" | grep '^ 0.00000  0.00000  0.00000' |wc -l

echo -n "color page numner: "
echo "$OUTPUT" | grep -v '^ 0.00000  0.00000  0.00000' |wc -l

echo -n "colored pages: "
echo "$OUTPUT" | grep -n -v '^ 0.00000  0.00000  0.00000' |\
	sed 's/\([0-9]*\).*/\1/g'|\
	perl -0pe 's/(\d+)\n(?=(\d+))/ $1+1==$2 ? "$1," : $& /ge; 
           s/,.*,/-/g' |\
	sed ':a;N;$!ba;s/\n/,/g'

else
	echo "Usage: $0 filename.pdf." >&2
fi
