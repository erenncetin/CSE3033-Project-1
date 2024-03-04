#!/bin/bash


ls -l $1

fileName=$( ls -t $1 | tail -n 1 )
echo $fileName


echo "Do you want to delete $fileName? (y/n): "
read answer
if [ $answer == "y" ] ;
then
        rm -r "$fileName"
        echo "1 file deleted"

elif [ $answer == "n" ]
then    echo "file is not deleted"

else
        echo "enter y or no please"
fi


ls -l $1