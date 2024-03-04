#! /bin/bash

# Check whether the given arguments are valid or not
function validArguments() {

    args=("$@")
    is_R=""
    pattern=""

    if [ "${#args[@]}" -eq 2 ] && [ "${args[0]}" == "-R" ]; then
        is_R="true"
        pattern="${args[1]}"
        echo "Your arguments are valid"
    elif [ "${#args[@]}" -eq 1 ] && [ "${args[0]}" != "-R" ]; then
        is_R="false"
        pattern="${args[0]}"
        echo "Your argument is valid"
    else
        echo -e "You need to pass two arguments as -R and a String or\nYou need pass argument as a String."
        exit
    fi
}

# According to path, create copy directories and copy appropriate file to the copy directory
function findFiles() {

    path_name=$PWD

    # If there is no recursion
    if [ $is_R == "false" ]; then
        mkdir -p copy
        find "$path_name" -maxdepth 1 -type f -name "$pattern" -exec bash -c 'if [ ! -e "$1/copy/$(basename "$0")" ]; then cp "$0" "$1/copy"; fi' {} "$path_name" \;

    else
        directories=()

        while IFS= read -r dir; do
        directories+=("$dir")
        done < <(find "$path_name" -type d | grep -v copy)

        for dir in "${directories[@]}"; do
        mkdir -p "$dir/copy"
        find "$dir" -maxdepth 1 -type f -name "$pattern" -exec bash -c 'if [ ! -e "$1/copy/$(basename "$0")" ]; then cp "$0" "$1/copy"; fi' {} "$dir" \;
        done
    fi
}

argss=("$@")
validArguments "${argss[@]}"
findFiles