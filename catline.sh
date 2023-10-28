#!/bin/bash
#            _   _ _            
#    ___ __ _| |_| (_)_ __   ___ 
#   / __/ _` | __| | | '_ \ / _ \
#  | (_| (_| | |_| | | | | |  __/
#   \___\__,_|\__|_|_|_| |_|\___|
#
# catline
# Version: 1.0.0
# Creation: 2023-10-27
# Author: yannawr
# Repository: github.com/yannawr/catline
#
# A simple Bash script to display the number of lines in files within a directory.
# You can choose which file extensions you want the script to read or exclude the
# extensions of files you don't want to be included.
# 
# To read all files within a directory, simply run the script without including any
# additional commands.
#
# This script was inspired by OFJAAH videos.
#
# Requirements:
# 1. None, really. But remember if running as portable, ensure this script has
# execute permissions. Use 'chmod +x ./catline.sh' to grant permissions.


directory="."

show_help() {
    echo "Welcome to catline!"
    echo ""
    echo "Options:"
    echo "  -e <extensions>   List of extensions to include (comma-separated)"
    echo "  -x <extensions>   List of extensions to exclude (comma-separated)"
    echo "  -i, -install      Install catline"
    echo "  -u, -uninstall    Uninstall catline"
    echo "  -h, -help         Show this help message"
    echo ""
    echo "Arguments must be used separately. Combinations like '-e txt -x php'" 
    echo "are not allowed."
    echo ""
    echo "To read all files within a directory, simply run the script without"
    echo "including any additional commands."
}

catline_install() {
    cp catline.sh /usr/local/bin/catline
    chmod +x /usr/local/bin/catline

    if [ -f "/usr/local/bin/catline" ] && [ -x "/usr/local/bin/catline" ]; then
        echo "catline successfully installed."
    else
        echo -e "\e[31mError: catline was not installed.\e[0m"
        catline_uninstall
    fi
}

catline_uninstall() {
    rm -r /usr/local/bin/catline

    if [ ! -f "/usr/local/bin/catline" ]; then
        echo "catline has been successfully removed."
    else
        echo -e "\e[31mError: catline was not uninstalled.\e[0m"
    fi
}

count_lines() {
    for file in "$directory"/*; do
        if [ -f "$file" ]; then
            filename="${file##*/}"
            ext="${filename##*.}"
            if [[ -z "$extension_list" || " ${extension_list[@]} " =~ " $ext " ]]; then
                if [[ -z "$excluded_extensions" || ! " ${excluded_extensions[@]} " =~ " $ext " ]]; then
                    lines=$(wc -l < "$file")
                    printf "%-5s %s\n" "$lines" "$filename"
                fi
            fi
        fi
    done
}

check_command() {
    if [ "$#" -eq 1 ]; then
        case "$1" in
            -i | -install)
                catline_install
                exit 0
                ;;
            -u | -uninstall)
                catline_uninstall
                exit 0
                ;;
            -h | -help)
                show_help
                exit 0
                ;;
        esac
    else
        echo "Error: Invalid usage of $1"
        exit 1
    fi
}

if [ "$#" -eq 1 ]; then
    case "$1" in
        -i | -install)
            catline_install
            exit 0
            ;;
        -u | -uninstall)
            catline_uninstall
            exit 0
            ;;
        -h | -help)
            show_help
            exit 0
            ;;
    esac
elif [ "$#" -eq 0 ]; then
    extension="*"
    count_lines
    exit 0
elif [ "$#" -eq 2 ]; then
    while [[ $# -gt 0 ]]; do
        case "$1" in   
            -e)
                shift
                extension_list="$1"
                ;;
            -x)
                shift
                excluded_extensions="$1"
                ;;
            *)
                echo "Invalid argument: $1"
                exit 1
                ;;
        esac
        shift
    done
else
    echo "Error: Invalid usage of $1"
    exit 1
fi

if [ -n "$extension_list" ]; then
    IFS=',' read -ra extensions <<< "$extension_list"
    for ext in "${extensions[@]}"; do
        extension="*.$ext"
        count_lines
    done
    exit 0
elif [ -n "$excluded_extensions" ]; then
    IFS=',' read -ra excluded_exts <<< "$excluded_extensions"
    count_lines
    exit 0
fi


echo "An error ocurred."
exit 1

