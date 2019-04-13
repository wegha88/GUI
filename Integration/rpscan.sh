#!/bin/bash

echo connect to PI
echo "Currently removing previous scan information"
rm -f /root/Final/outputs/scanoutput.csv

if [[ ! -f /root/Final/outputs/withNull.csv ]]
then
	echo "No selected access point file detected, please run the wire creator first"
	exit
fi
if [[ ! -f /root/Final/outputs/withNull.csv ]]
then
	echo "No wire file detected, please run the wire creator first"
	exit
fi
echo "Creating arrays"
readarray array < /root/Final/outpurs/withNull.csv
readarray AP < /root/Final/outputs/outpoints.csv
echo "arrays complete, initiating scan sequence"
skip=0
for i in "${arrays[@]}"
do
	if [ $skip != 0 ]
	then
		var=$1
		for j in "${var[@]}"
		do
			IFS="," read -r -a splitter <<< $j
			read -p "currently editing ${splitter[0]}, ${splitter[1]}, press enter to continue"
			echo ${splitter[0]}, ${splitter[1]} >> /root/Final/outputs/scanoutput.csv
			bash /root/Final/scripts/signalreturn.sh > /root/Final/outputs/foundsignals.csv
			readarray resu < /root/Final/outputs/foundsignals.csv
			for k in "${resu[0]}"
			do
				IF="," read -r -a resultsplitter <<< $resu
				echo ${k[0]} >> /root/Final/outputs/scanoutput.csv
			done
		done
	fi
	skip=$((skip + 1))
done


exit
