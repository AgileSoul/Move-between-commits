![](https://i.ibb.co/B6VtWVw/move-Commits.png)

[TOCM]

[TOC]

## Español

Moverse entre commits es un bash shell-script basado en git que nos permite ir a un commit anterior o ir a un commit siguiente sin necesidad de copiar y pegar el id del commit cada vez que querramos ir un commit adelante o atras.

##### Como usar:

>     ./moveBetweenCommits.sh  [ -n | --next ] For next commit
>                              [ -b | --back ] For previus commit

##### Por ejemplo:

    bash moveBetweenCommits.sh -b

## English

Moving between commits is a git-based bash shell-script that allows us to go to a previous commit or go to a next commit without the need to copy and paste the commit id every time we want to go forward or backward a commit.

##### How to use: 

>     bash moveBetweenCommits.sh  [ -n | --next ] For next commit
>                                 [ -b | --back ] For previus commit

##### For example:

    ./moveBetweenCommits.sh --next
