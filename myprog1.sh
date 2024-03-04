#!/bin/bash

dataList=(0,0,0,0,0,0,0,0,0,0)

function setDataList() {
    ((dataList[$1]++))
}

function readData() {
    while IFS= read -r line || [ -n "$line" ]
    do
        num=$(echo "$line" | tr -cd '[:digit:]')
        setDataList "$num"
    done < $1
}

function printStar() {
    len=$1
    for ((k = 0; k < len; k++))
    do
        echo -n "*"
    done
}

function printResult() {
    for ((i = 0; i < 10; i++))
    do
        echo -n "$i "
        printStar ${dataList[i]}
        echo
    done
}


readData $1
printResult