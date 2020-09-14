# Fruit-Basket-App

[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Bash_Logo_black_and_white_icon_only.svg/512px-Bash_Logo_black_and_white_icon_only.svg.png)](https://nodesource.com/products/nsolid)

## Overview
This is an command-line application written by bash scripting and designed to run on Linux distributions.
A user should be able to create the report by providing the path to the CSV-file to the application. The CSV-file represents a catalog of all the fruit in a fruit bowl.

Each line is a piece of fruit. The data representing a particular fruit include:

| fruit type | age in days | ad-hoc characteristic 1 | ad-hoc characteristic 2

## Prerequisites 

Need to have read write and execution permission for the logged in user.
Required GNU Awk 4.1.3, API: 1.1 (GNU MPFR 3.1.4, GNU MP 6.1.0) version or above 
Need to have an editor tool (VIM , Nano etc..)

Make sure to have git installed as a dependency
```sh
apt-get update
apt-get install git
```

### Installation

Clone the application using the below command

```sh
git clone https://github.com/Dasithz/Fruit-Basket-App.git
```
Navigate to the application folder 
```sh
cd Fruit-Basket-App
```

Upload your CSV file to the prefered location and make sure you have access to the uploaded location from the logged in user.

Open the fruitbasketapp.sh application using your desired editor. 
Locate the below 

```sh
#!/bin/bash
filepath=/home/dasitha/
filename=test.csv
processedfile=processed.csv
header=1
absolutefile=$filepath$filename
$ NODE_ENV=production node app
```
1 Change the filepath variable to the path where you have uploaded the CSV file.
2 Change te file name to the exact file name which you have uploaded.
3 Save and exit 
4. Execute the script  ```./fruitbasketapp.sh ```

### Sample Out put

```
root@instance-1:/home/dasitha# ./fruitbasketapp.sh
 test.csv exists. Continuing to process data...

number of fruits:
21

Total types of fruits:
4

Oldest fruit & age:
pineapple: 6
orange: 6

The number of each type of fruit in descending order:
orange: 6
apple: 5
pineapple: 4
grapefruit: 4
watermelon: 3

The various characteristics (count, color, shape, etc.) of each fruit by type:
      1 apple: green, tart
      3 apple: red, sweet
      1 apple: yellow, sweet
      2 grapefruit: bitter, yellow
      2 grapefruit: yellow, bitter
      5 orange: round, sweet
      1 orange: sweet, round
      2 pineapple: prickly, sweet
      2 pineapple: sweet, prickly
      1 watermelon: green, heavy
      2 watermelon: heavy, green

root@instance-1:/home/dasitha#
```

![Execution](https://github.com/Dasithz/Fruit-Basket-App/blob/master/Help/Images/Sample_Out_Put.PNG)

> Success execution

### Implemented CSV validations

- Check whether all required columns (4) exist or not
- Check whether the exactly the second column contains only numbers
- Validated all other columns for Alphabetic characters
- File location validation 

### Error Dictionary 

| Exit Code |                                                                                                                                         Message                                                                                                                                         |
|:---------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| `exit 1`  | File <filename> does not exist in the <filepath>.  Terminating the script! Exit code set to 1                                                                                                                                                                                           |
| `exit 2`  | Exit Code : 2 ! Terminating the script due to the csv validation failure! CSV contains more or less fields than expected.  Please check the <filename> file which located under <filepath>                                                                                              |
| `exit 3`  | Exit Code : <exit_code> ! Terminating the script due to the csv validation failure! 2nd field needs to contain numerical value....  Please check the <filename> file which located under <filepath>"                                                                                    |
| `exit 4`  | Numerical values detected in the 1st field of the CSV file! Please check... Exit Code : 4 ! Terminating the script due to the csv validation failure! Unexpected numerical value detection. Expected value: characters. Please check the <filename> file which located under <filepath> |
| `exit 5`  | Numerical values detected in the 2nd field of the CSV file! Please check... Exit Code : 5 ! Terminating the script due to the CSV validation failure! Unexpected numerical value detection. Expected value: characters. Please check the <filename> file which located under <filepath> |
| `exit 6`  | Numerical values detected in the 4th field of the CSV file! Please check... Exit Code : 5 ! Terminating the script due to the CSV validation failure! Unexpected numerical value detection. Expected value: characters. Please check the <filename> file which located under <filepath> |
