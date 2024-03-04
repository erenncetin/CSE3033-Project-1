#! /bin/bash

# Check the arguments whether they are valid or not
function checkValidity() {
    
    args=("$@")

    if [ "${#args[@]}" -ne 2 ] 
    then
        echo "Please enter two arguments as a String and number"
        exit
    elif [[ ! "${args[0]}" =~ ^[a-zA-Zi]+$ ]] 
    then
        echo "The first argument will be String and consists of only letters"
        exit
    elif [[ ! "${args[1]}" =~ ^[0-9]+$ ]] || [[ ${#args[0]} -lt ${#args[1]} ]] 
    then
        echo "The second argument will be integer and length of that number will be equal or less than String length"
        exit
    else
        echo "Passed Arguments are valid"
    fi 
}

# Crypte given message 
function crypteMessage() {
    
    unencryptedMessage="$1"
    unencryptedIndex=0
    lengthOfTheMessage="${#unencryptedMessage}"

    numberOfPushes="$2"
    numberOfPushesIndex=0
    lengthOfThePushes="${#numberOfPushes}"

    encryptedMessage=""

    while [ $unencryptedIndex -ne $lengthOfTheMessage ]; do
        ascii_code=$(printf "%d" "'${unencryptedMessage:$unencryptedIndex:1}")
        newASCIICode=$((ascii_code + ${numberOfPushes:$numberOfPushesIndex:1}))
        if [ $ascii_code -lt 90 ]; then
            if [ $newASCIICode -gt 90 ]; then
                newASCIICode=$((65 + newASCIICode - 91))
            fi
        else
            if [ $newASCIICode -gt 122 ]; then
                newASCIICode=$((97 + newASCIICode - 123))
            fi
        fi
        newCharacter=$(printf "\\$(printf '%03o' "$newASCIICode")")
        encryptedMessage="${encryptedMessage}${newCharacter}"
        ((unencryptedIndex++))

        if [ $numberOfPushesIndex -lt $((lengthOfThePushes - 1)) ]; then
            ((numberOfPushesIndex++))
        fi
    done

    echo "$encryptedMessage"
}

checkValidity $@
crypteMessage $@
