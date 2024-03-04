#! /bin/bash

function run() {
    res=""

    while IFS= read -n 1 c
    do
        if [[ -z "$c" ]]; 
        then
            echo ""
        fi

        if [[ "$c" == " " ]]; 
        then
            echo -n " "
        fi
        
        res=$(changeNumber2String $c)
        echo -n "$res"

    done < "$1" > "./tempOutput.txt"
}

function changeNumber2String() {
    local data=$1

    case $data in
        "0" )
        echo "zero";;

        "1" )
        echo "one";;

        "2" )
        echo "two";;

        "3" )
        echo "three";;

        "4" )
        echo "four";;

        "5" )
        echo "five";;

        "6" )
        echo "six";;

        "7" )
        echo "seven";;

        "8" )
        echo "eight";;

        "9" )
        echo "nine";;

        * )
        echo $data;;
    esac
}

run $1
cat tempOutput.txt > $1
rm tempOutput.txt
