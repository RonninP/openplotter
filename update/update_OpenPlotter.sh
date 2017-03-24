#!/bin/bash

echo
echo "CREATING OPENPLOTTER CODE BACKUP..."
echo
cd ~/.config
DIRDATE=`date +openplotter_bak_%Y_%m_%d:%H:%M:%S`
cp -a openplotter/ $DIRDATE/
cd $DIRDATE
find . -name "*.pyc" -type f -delete
echo
echo "DOWNLOADING NEW OPENPLOTTER CODE..."
echo
cd ~/.config
rm -rf openplotter_tmp
if [ $3 = "stable" ]; then
	git clone https://github.com/sailoog/openplotter.git openplotter_tmp
else
	git clone -b beta https://github.com/sailoog/openplotter.git openplotter_tmp
fi
if [ $1 = 1 ]; then
	source openplotter_tmp/update/update_dependencies.sh
fi
source openplotter_tmp/update/update_settings.sh
echo
echo "COMPRESSING BACKUP INTO HOME..."
echo
tar cvjf ~/$DIRDATE.tar.bz2 $DIRDATE
echo
echo "DELETING FILES..."
echo
rm -rf openplotter
rm -rf $DIRDATE
mv openplotter_tmp openplotter
echo
echo "RESTARTING OPENPLOTTER..."
echo
startup restart
echo
read -p "FINISHED, PRESS ENTER TO EXIT."
