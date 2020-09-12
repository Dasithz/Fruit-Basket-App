#!/bin/bash
filename=test.csv
processedfile=processed.csv
header=1


if [ -f "$filename" ]; then
    echo -e "\e[33m $filename exists. Continuing to process data..."
    echo -e "\e[0m"
else
    echo -e "\e[31m File $filename does not exist. Terminating the script!"
    echo -e "\e[0m"
    exit 1
    #echo "exit code: $?"
fi

#CSV Validation
awk 'FNR>2 || NR==2' ./*$filename > $processedfile

awk 'BEGIN{FS=OFS=","} NF!=4{print "not enough fields"; exit 1} !($2 ~ "^[0-9][0-9]*$") {print"2nd field need to contain numerical values. please check"; exit 1 }' $processedfile



ecode=$?
if [ $ecode -ne 0 ]; then
    echo -e "\e[31mTerminating the script due to the csv validation failure"
    echo -e "\e[0m"
fi

fruits=$(cat $processedfile | wc -l)
distinct=$(cut -d, -f1 $processedfile | sort -u | wc -l)

echo -e "number of \e[31mfruits:\e[0m"
echo $(($fruits-$header)); echo 

echo -e "Total types of \e[31mfruis:\e[0m" 
echo $(($distinct-$header)); echo

echo -e "Oldest fruit & \e[31mage:\e[0m"
cat $processedfile |awk -v maxVal=$(cat $processedfile |awk -F',' '{print $2}'|sort -n|tail -1) -F',' '{if($2==maxVal) print "\033[0;31m"$1"\033[0m"   ": "$2}'
echo


echo -e "The number of each type of fruit in descending \e[31morder:\e[0m"

cat $processedfile |awk -F, '{A[$1]++}END{for(i in A)print "\033[0;31m"i"\033[0m" ": " A[i]}'
echo

echo -e "The various characteristics (count, color, shape, etc.) of each fruit by \e[31mtype:\e[0m"
cat $processedfile |awk -F, '{print "\033[0;31m"$1"\033[0m" ": " $3 ", " $4}'|sort -n|uniq -c
echo

rm $processedfile
