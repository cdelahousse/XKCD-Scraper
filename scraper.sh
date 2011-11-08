#COMICNO=`tail -n 1 imgs/altText.txt | awk '{ print $1 }'`
COMICNO=403
echo $COMICNO
while 	((COMICNO += 1))
	if [ $COMICNO == 404 ]; then #xkcd.com/404 is well... 404 error page
		continue #so skip loop iteration
	fi
	source=`curl -s http://www.xkcd.com/$COMICNO/ | grep -m 1 "http://imgs.xkcd.com/comics/"`
	#echo $source
	if [ $source == '' ]; then #all done! No more left to download
		exit
	fi
	filename=`echo $source | cut -d\/ -f5 | cut -d\" -f1 | cut -d\. -f1`
	echo $filename
	[ ${#source} -ne 0 ]
	do
		echo "Downloading Comic "$COMICNO
		img=$source
		img=${img#<img src=\"}
		img=${img%%\"*>}
		alt=$source
		alt=${alt#<*title=\"}
		alt=${alt%%\"*>}
		echo  $alt >> $COMICNO.txt
		#filanme: ###-name.jpg
		wget -q -O "$COMICNO-$filename".jpg $img

		sleep 1 #Rate limiting as to not stress Randal Monroe's server. Be nice kids!

	done
