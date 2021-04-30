#!/bin/bash
#Autor: AgileSoul
#Programa para moverme entre commits usando el script -opcion
clear
if [ -z $1 ]; then
    echo -e "\e[0;36mYou have not any entered any option\e[0m"
    echo -e "\e[1;37mUsage: bash recorrerCommits.sh [ -n | --next ] For next commit\e[0m"
    echo -e "                               \e[1;37m[ -b | --back ] For previus commit\e[0m"
else
    allCommits=($(git log --pretty=format:"%H" --all))
    commitHead=$(git log --pretty=format:"%H" -1)
    positionHead=0
    commitRecent=${allCommits[0]}
    commitOlder=${allCommits[${#allCommits[*]} - 1]}
    
    #Get the position of the array where it is equal to commitHead
    for ((i=0; i<${#allCommits[@]}; i++))
    do
        if [ ${allCommits[$i]} = $commitHead ]; then
            positionHead=$i
        fi
    done
    #Print the head position
    echo -e "\e[32mYou are in:\e[0m\e[1;97;40m\n$(git branch)\n\e[0m"

    #Next commit
    if [ $1 = "-n" ] || [ $1 = "--next" ]; then
        if [ $commitHead = $commitRecent ];then
            echo -e "\e[35mYou are already in the last commit, there aren't more recent commits\e[0m"
        else
            positionHead=$((positionHead - 1))
            git checkout ${allCommits[$positionHead]}
            #Print the new position
            echo -e "\e[32mNow you are in:\e[0m\e[1;97;40m\n$(git branch)\n\e[0m"
        fi
    #Previus commit    
    elif [ $1 = "-b" ] || [ $1 = "--back" ]; then       
        if [ $commitHead = $commitOlder ];then
            echo -e "\e[35mYou are already in the first commit, there aren't older commits\e[0m"
        else
            positionHead=$((positionHead + 1))
            git checkout ${allCommits[$positionHead]}
            #Print the new position
            echo -e "\e[32mNow you are in:\e[0m\e[1;97;40m\n$(git branch)\n\e[0m"
        fi
    #Invalid option    
    else
        echo -e "\e[0;36mYou entered an invalid option\e[0m"
        echo -e "\e[1;37mUsage: bash recorrerCommits.sh [ -n | --next ] For next commit\e[0m"
        echo -e "                               \e[1;37m[ -b | --back ] For previus commit\e[0m"
    fi 
fi

#clean
unset allCommits commitHead positionHead commitRecent commitOlder
echo -e "\e[0;36mCleaning and exiting...\e[0m"

