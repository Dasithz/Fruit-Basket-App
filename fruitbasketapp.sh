#!/bin/bash
filepath=/home/dasitha/
filename=test.csv
processedfile=processed.csv
header=1
absolutefile=$filepath$filename


if [ -f "$filepath$filename" ]; then
    echo -e "\e[33m $filename exists. Continuing to process data..."
    echo -e "\e[0m"
else
    echo -e "\e[31m Exit Code: 1 File $filename does not exist in the $filepath. Terminating the script! "
    echo -e "\e[0m"
    exit 1 
fi

awk 'FNR>2 || NR==2' $absolutefile > $processedfile

awk 'BEGIN{FS=OFS=","} NF!=4{print " "; exit 2} !($2 ~ "^[0-9][0-9]*$") {print" "; exit 3 }' $processedfile

ecode=$?
if [ $ecode -eq 2 ]; then
    echo -e "\e[31m Exit Code : $ecode ! Terminating the script due to the csv validation failure! CSV contains more or less fields than expected. Please check the $filename file which located under $filepath"
    echo -e "\e[0m"
    rm $processedfile
    exit 1
fi

if [ $ecode -eq 3 ]; then
    echo -e "\e[31m Exit Code : $ecode ! Terminating the script due to the csv validation failure! 2nd field needs to contain numerical value.... Please check the $filename file which located under $filepath"
    echo -e "\e[0m"
    rm $processedfile
    exit 1
fi



awk 'BEGIN{FS=OFS=","} !($1 ~ "^[a-zA-Z][a-zA-Z]*$") {print "\033[31mNumerical values detected in the 1st field of the CSV file! Please check... \033[0m "; exit 4 }' processed.csv
ecode=$?
if [ $ecode -eq 4 ]; then
    echo -e "\e[31m Exit Code : $ecode ! Terminating the script due to the csv validation failure! Unexpected numerical value detection. Expected value : characters. Please check the $filename file which located under $filepath"
    echo -e "\e[0m"
    rm $processedfile
    exit 1
fi

awk 'BEGIN{FS=OFS=","} !($3 ~ "^[a-zA-Z][a-zA-Z]*$") {print "\033[31mNumerical values detected in the 3rd field of the CSV file! Please check... \033[0m "; exit 5 }' $processedfile
ecode=$?
if [ $ecode -eq 5 ]; then
    echo -e "\e[31m Exit Code : $ecode ! Terminating the script due to the csv validation failure! Unexpected numerical value detection. Expected value : characters. Please check the $filename file which located under $filepath"
    echo -e "\e[0m"
    rm $processedfile
    exit 1
fi


awk 'BEGIN{FS=OFS=","} !($4 ~ "^[a-zA-Z][a-zA-Z]*$") {print "\033[31mNumerical values detected in 4th field of the csv file! Please check \033[0m "; exit 6 }' $processedfile
ecode=$?
if [ $ecode -eq 6 ]; then
    echo -e "\e[31m Exit Code : $ecode ! Terminating the script due to the csv validation failure! Unexpected numerical value detection. Expected value : characters. Please check the $filename file which located under $filepath"
    echo -e "\e[0m"
    rm $processedfile
    exit 1
fi


fruits=$(cat $processedfile | wc -l)
distinct=$(cut -d, -f1 $processedfile | sort -u | wc -l)

echo -e "number of \e[31mfruits:\e[0m"
echo $(($fruits-$header)); echo 

echo -e "Total types of \e[31mfruits:\e[0m" 
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
