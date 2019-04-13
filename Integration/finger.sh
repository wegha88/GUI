#!/bin/ash ifs.sh

#reading in variables to check with
declare -a check={ "$@" )
#declare -a check=(-26 -46 -59 -53 -54 )

#setting the directory and the base to check against
cd "$(dirname "$0"0)"
lowest="10000"
lowestRP="nothing"

#reading in the array from the scan phase
readarray array < /root/Final/outputs/fingeroutput.csv

#looping through the array
for i in "${array[@]}"
do
	var=$i
	for j in "${var[@]}"
	do
		IFS=",' read -r -a splitter <<< $j
#performing the formula functionality, retuns the result
		result=$(python square.py ${splitter[1]} ${check[0]} ${splitter[2]} ${check[1]} ${splitter[3]} ${check[2]} ${splitter[4]} ${check[3]} ${splitter[5]} ${check[4]})
#check whether the result of the formula is lower than the currently saved one
		truth=$(python truthcheck.py $result $lowest)
#check the result if it needs to change the lowest
		if [ $truth != "false" ];
		then
			lowest=$result
			lowestRP=${j[0]}
		fi
	done
done
#return the lowest result
echo $lowestRP
