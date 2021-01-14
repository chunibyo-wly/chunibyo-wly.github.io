---
typora-root-url: ..
title: Terraria
mathjax: true
date: 2020-02-09 12:33:46
tags:
	- game
	- linux
categories:
	- 运维
---
![Terraria](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/Terraria-vita-header.jpeg)

<!-- more -->

### Vanilla Server

#### [Downloads](https://terraria.gamepedia.com/Server#How_to_.28Linux.29)

![image-20200209124457124](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20200209124457124.png)

#### Start Dedicated Server

1. Make sure the script and program files have execute permissions by using the command `chmod u+x TerrariaServer*`(注意这里是通配符)
2. Since the server will stop if the terminal session is ended, you can use a program like `tmux` or `screen` to keep the session running while you are logged out.

#### Setting up dedicated server with configuration file

```shell
./TerrariaServer -config <serverconfigfile>
```

#### Making a configuration file

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

#### World File Location

`~/.local/share/Terraria/Worlds`

#### 生成service

```
# /lib/systemd/system/terraria.service
[Unit]
Description=server daemon for terraria

[Service]
Type=forking
User=root
KillMode=none
ExecStart=/usr/bin/screen -dmS terraria /bin/bash -c "/root/terraria/TerrariaServer.bin.x86_64 -config /root/terraria/serverconfig.txt 2>&1 | tee /root/log_ws/terraria.log"
ExecStop=/usr/local/bin/terrariad exit

[Install]
WantedBy=multi-user.target
```

```
#!/bin/bash
# /usr/local/bin/terrariad

send="`printf \"$*\r\"`"
attach="screen -r terraria"
inject="screen -S terraria -X stuff $send"

if [ "$1" = "attach" ] ;
then
    cmd="$attach" ;
else
    cmd="$inject" ;
fi

$cmd
```

```
systemctl start terraria.service
terrariad <command>
terrariad attach
```

```
$ systemctl status terraria.service
● terraria.service - server daemon for terraria
   Loaded: loaded (/lib/systemd/system/terraria.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2020-02-09 20:46:51 CST; 2h 2min ago
 Main PID: 369 (screen)
    Tasks: 10 (limit: 4680)
   CGroup: /system.slice/terraria.service
           ├─369 /usr/bin/SCREEN -dmS terraria /bin/bash -c /root/terraria/TerrariaServer.bin.x86_64 -config           ├─397 /bin/bash -c /root/terraria/TerrariaServer.bin.x86_64 -config /root/terraria/serverconfig.t           ├─409 /root/terraria/TerrariaServer.bin.x86_64 -config /root/terraria/serverconfig.txt
           └─410 tee /root/log_ws/terraria.log

Feb 09 20:46:51 iZbp13dkrvca9v6gpgqk8zZ systemd[1]: Starting server daemon for terraria...
Feb 09 20:46:51 iZbp13dkrvca9v6gpgqk8zZ systemd[1]: Started server daemon for terraria.
lines 1-13/13 (END)
```

### tModLoaderServer

#### [Downloads](https://github.com/tModLoader/tModLoader/releases)

![image-20200210233224440](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20200210233224440.png)

#### 使用

1. 解压之后全部`mv`进`terraria`的工作空间
   ![image-20210114200611046](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114200611046.png)

2. 修改`serverconfig.txt`

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
   world=/root/.local/share/Terraria/ModLoader/Worlds/AccelWorld.wld
   
   #Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).       autocreate=3
   
   #Sets the name of the world when using autocreate
   worldname=AccelWorld
   
   #Sets the difficulty of the world when using autocreate 0(normal), 1(expert)
   difficulty=0
   
   #Sets the max number of players allowed on a server.  Value must be between 1 and 255
   maxplayers=4
   
   #Set the port number
   port=7777
   
   #Set the server password
   #password=
   
   #Set the message of the day
   motd=少年, 你想不想..."加速"到更快的境界?
   
   #Sets the folder where world files will be stored
   worldpath=/root/.local/share/Terraria/ModLoader/Worlds
   
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

   

3. 修改`terraria.service`

   ```
   [Unit]
   Description=[泰拉瑞亚]service
   
   [Service]
   Type=forking
   User=root
   KillMode=none
   ExecStart=/usr/bin/screen -dmS terraria /bin/bash -c "/root/terraria/tModLoaderServer.bin.x86_64 -config /root/terraria/serverconfig.txt 2>&1 | tee /root/log_ws/terraria.log"
   ExecStop=/usr/local/bin/terrariad exit
   
   [Install]
   WantedBy=multi-user.target
   ```

#### Worlds & Mods

| 名称           | 位置                                      |
| :------------- | :---------------------------------------- |
| vanilla worlds | ~/.local/share/Terraria/Worlds/           |
| mod worlds     | ~/.local/share/Terraria/ModLoader/Worlds/ |
| mod mods       | ~/.local/share/Terraria/ModLoader/Mods/   |