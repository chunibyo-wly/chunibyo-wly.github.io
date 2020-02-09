---
typora-root-url: ..
title: Terraria
mathjax: true
date: 2020-02-09 12:33:46
tags:
	- game
categories:
	- server
---
![Terraria](/images/Terraria-vita-header.jpeg)

<!-- more -->

### [Downloads](https://terraria.gamepedia.com/Server#How_to_.28Linux.29)

![image-20200209124457124](/images/image-20200209124457124.png)

### Start Dedicated Server

1. Make sure the script and program files have execute permissions by using the command `chmod u+x TerrariaServer*`(注意这里是通配符)
2. Since the server will stop if the terminal session is ended, you can use a program like `tmux` or `screen` to keep the session running while you are logged out.

### Setting up dedicated server with configuration file

```shell
./TerrariaServer -config <serverconfigfile>
```

### Making a configuration file

```
#this is an example config file for TerrariaServer.exe
#use the command 'TerrariaServer.exe -config serverconfig.txt' to use this configuration or run start-server.bat
#please report crashes by emailing crashlog.txt to support@terraria.org

#the following is a list of available command line parameters:

#-config <config file>                          Specifies the configuration file to use.
#-port <port number>                              Specifies the port to listen on.
#-players <number> / -maxplayers <number>   Sets the max number of players
#-pass <password> / -password <password>    Sets the server password
#-world <world file>                              Load a world and automatically start the server.
#-autocreate <#>                                Creates a world if none is found in the path specified by -world. World size is specified by: 1(small), 2(medium), and 3(large).
#-banlist <path>                                Specifies the location of the banlist. Defaults to "banlist.txt" in the working directory.
#-worldname <world name>                        Sets the name of the world when using -autocreate.
#-secure                                            Adds addition cheat protection to the server.
#-noupnp                                            Disables automatic port forwarding
#-steam                                             Enables Steam Support
#-lobby <friends> or <private>             Allows friends to join the server or sets it to private if Steam is enabled
#-ip <ip address>   Sets the IP address for the server to listen on
#-forcepriority <priority>  Sets the process priority for this task. If this is used the "priority" setting below will be ignored.

#remove the # in front of commands to enable them.

#Load a world and automatically start the server.
world=/root/.local/share/Terraria/Worlds/test2.wld

#Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).
autocreate=2

#Sets the name of the world when using autocreate
worldname=test2

#Sets the difficulty of the world when using autocreate 0(normal), 1(expert)
difficulty=0

#Sets the max number of players allowed on a server.  Value must be between 1 and 255
maxplayers=6

#Set the port number
port=7777

#Set the server password
password=foo

#Set the message of the day
motd=Please dont cut the purple trees!

#Sets the folder where world files will be stored
worldpath=/root/.local/share/Terraria/Worlds

#The location of the banlist. Defaults to "banlist.txt" in the working directory.
banlist=banlist.txt

#Adds addition cheat protection.
secure=1

#Sets the server language 1:English, 2:German, 3:Italian, 4:French, 5:Spanish
lang=1

#Automatically forward ports with uPNP
#upnp=1

#Reduces enemy skipping but increases bandwidth usage. The lower the number the less skipping will happen, but more data is sent. 0 is off.
#npcstream=60

#Default system priority 0:Realtime, 1:High, 2:AboveNormal, 3:Normal, 4:BelowNormal, 5:Idle
priority=1
```

### World File Location

`~/.local/share/Terraria/Worlds`