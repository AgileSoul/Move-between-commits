#!/bin/bash
#Autor: AgileSoul
#Program to move to a previus or later commit
clear

allCommits=()
commitHead=""
positionHead=0
commitRecent=""
commitOlder=""

function howToUse()
{
    echo -e "\e[1;37mUsage: bash recorrerCommits.sh [ -n | --next ] For next commit\e[0m"
    echo -e "                               \e[1;37m[ -b | --back ] For previus commit\e[0m"
}
function getCommits()
{ 
    allCommits=($(git log --pretty=format:"%H" --all))
    commitHead=$(git log --pretty=format:"%H" -1)
    commitRecent=${allCommits[0]}
    commitOlder=${allCommits[${#allCommits[*]} - 1]}
}
function getPositionHead()
{       
    for ((i=0; i<${#allCommits[@]}; i++))
    do
        if [ ${allCommits[$i]} = $commitHead ]; then
            positionHead=$i
        fi
    done
}
function doGitCheckout()
{
    git checkout ${allCommits[$positionHead]}
    #Print the new position
    echo -e "\e[32mNow you are in:\e[0m\e[1;97;40m\n$(git branch)\n\e[0m" 
}
function nextCommit()
{
    if [ $commitHead = $commitRecent ];then
        echo -e "\e[35mYou are already in the last commit, there aren't more recent commits\e[0m"
    else
        positionHead=$((positionHead - 1))
        doGitCheckout
    fi    
}
function backCommit()
{
    if [ $commitHead = $commitOlder ];then
        echo -e "\e[35mYou are already in the first commit, there aren't older commits\e[0m"
    else
        positionHead=$((positionHead + 1))
        doGitCheckout
    fi   
}
function clean()
{
    unset allCommits commitHead positionHead commitRecent commitOlder
    echo -e "\e[0;36mCleaning and exiting...\e[0m"
}

if [ -z $1 ]; then
    echo -e "\e[0;36mYou have not any entered any option\e[0m"
    howToUse
else
    getCommits
    #Get the position of the array where it is equal to commitHead
    getPositionHead
    #Print the HEAD position
    echo -e "\e[32mYou are in:\e[0m\e[1;97;40m\n$(git branch)\n\e[0m"

    #Next commit
    if [ $1 = "-n" ] || [ $1 = "--next" ]; then
        nextCommit
    #Previus commit    
    elif [ $1 = "-b" ] || [ $1 = "--back" ]; then  
        backCommit
    #Invalid option    
    else
        echo -e "\e[0;36mYou entered an invalid option\e[0m"
        howToUse
    fi 
fi
#clean
clean
