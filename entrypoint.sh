#!/bin/bash

function random
{
   array=( "ergosterol" "damnableness" "springhouse" "petrify" "preintellectual" "redecay" "tendril" "nonrestrained" "isostemony" "preaccount" "clubman" "pantelleria" "tomato" "talooka" "provenal" "portobello" "clarksburg" "preexecution" "pourer" "chlorpheniramine")
   D=`date -Iseconds`

   tags="[${array[$RANDOM % ${#array[@]} ]}=${array[$RANDOM % ${#array[@]} ]}] [${array[$RANDOM % ${#array[@]} ]}=${array[$RANDOM % ${#array[@]} ]}] [${array[$RANDOM % ${#array[@]} ]}]"
   IP1="172.172.172.$(($RANDOM % 64))"
   IP2="172.172.172.$(($RANDOM % 64))"
   EXTRA="$tags $IP1 $IP2"

   echo $1 | sed "s/<!--D-->/$D/" | sed "s/<!--EXTRA-->/$EXTRA/"
}

function json
{
   D=$(date "+%Y/%m/%d %H:%M:%S")

   IP1="172.172.172.$(($RANDOM % 64))"
   IP2="172.172.172.$(($RANDOM % 64))"
   IP3="172.172.172.$(($RANDOM % 64))"
   echo $1 | sed "s~<!--D-->~$D~" | sed "s~<!--IP1-->~$IP1~" | sed "s~<!--IP2-->~$IP2~" | sed "s~<!--IP3-->~$IP3~"
}


function apache
{
  IP1="172.172.172.$(($RANDOM % 64))"
  D=$(date "+%a  %b %d %H:%M:%S %Y")
  echo $1 | sed "s/1.2.3.4/$IP1/" | sed "s/<!--D-->/$D/"
}

function sshd
{
  IP1="172.172.172.$(($RANDOM % 64))"
  D=$(date "+%a  %b %d %H:%M:%S %Y")
  echo $1 | sed "s/<!--IP-->/$IP1/" | sed "s/<!--D-->/$D/"
}

function multiline
{
  D=$(date "+%b %d %H:%M:%S")
  echo $1 | sed "s/<!--D-->/$D/"
  echo "    at com.myproject.module.MyProject.badMethod(MyProject.java:22)"
  echo "    at com.myproject.module.MyProject.oneMoreMethod(MyProject.java:18)"
  echo "    at com.myproject.module.MyProject.anotherMethod(MyProject.java:14)"
  echo "    at com.myproject.module.MyProject.someMethod(MyProject.java:10)"
}

declare -A collections

if [ $3 = 'apache' ]; then
  logs=(
    "[<!--D-->] [error] [client 1.2.3.4] Directory index forbidden by rule: /home/test/"
    "[<!--D-->] [error] [client 1.2.3.4] Directory index forbidden by rule: /apache/web-data/test2"
    "[<!--D-->] [error] [client 1.2.3.4] Client sent malformed Host header"
    "[<!--D-->] [error] [client 1.2.3.4] user test: authentication failure for \"/~dcid/test1\": Password Mismatch"
    "[<!--D-->] [notice] Apache/1.3.11 (Unix) mod_perl/1.21 configured -- resuming normal operations"
    "[<!--D-->] [notice] Digest: generating secret for digest authentication ..."
    "[<!--D-->] [notice] Digest: done"
    "[<!--D-->] [notice] Apache/2.0.46 (Red Hat) DAV/2 configured -- resuming normal operations"
    "[<!--D-->] [notice] SIGHUP received.  Attempting to restart"
    "[<!--D-->] [notice] suEXEC mechanism enabled (wrapper: /usr/local/apache/sbin/suexec)"
    "[<!--D-->] [warn] pid file /opt/CA/BrightStorARCserve/httpd/logs/httpd.pid overwritten -- Unclean shutdown of previous Apache run?"
    "[<!--D-->] [notice] Apache/2.0.46 (Red Hat) DAV/2 configured -- resuming normal operations"
    "[<!--D-->] [notice] Digest: generating secret for digest authentication ..."
    "[<!--D-->] [notice] Digest: done"
    "[<!--D-->] [notice] caught SIGTERM, shutting down"
    "[<!--D-->] [error] (11)Resource temporarily unavailable: fork: Unable to fork new process"
  )
fi

if [ $3 = 'random' ]; then
  logs=(
      "<!--D--> INFO This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. <!--EXTRA-->"
      "<!--D--> WARN A warning that should be ignored is usually at this level and should be actionable. <!--EXTRA-->"
      "<!--D--> DEBUG This is a debug log that shows a log that can be ignored. <!--EXTRA-->"
  )
fi



if [ $3 = 'sshd' ]; then
  logs=(
      "<!--D--> stamina sshd[7713]: Did not receive identification string from <!--IP-->"
      "<!--D--> stamina sshd[82181]: error: accept: Software caused connection abort"
      "<!--D--> slacker2 sshd[8813]: Accepted password for root from <!--IP--> port 1066 ssh2"
      "<!--D--> chaves sshd[19537]: Invalid user admin from spongebob.lab.ossec.net"
      "<!--D--> chaves sshd[12914]: Failed password for invalid user test-inv from spongebob.lab.ossec.net"
      "<!--D--> kiko sshd[3251]: User dcid not allowed because listed in DenyUsers"
  )
fi

if [ $3 = 'json' ]; then
  logs=(
      "{\"message\" : \"some debug test message\", \"time\" : \"<!--D-->\", \"ips\" : [\"<!--IP1-->\", \"<!--IP3-->\"], \"ip2\" : \"<!--IP2-->\"}"
      "{\"message\" : \"some error test message\", \"time\" : \"<!--D-->\", \"ips\" : [\"<!--IP1-->\", \"<!--IP3-->\"], \"ip2\" : \"<!--IP2-->\"}"
      "{\"message\" : \"some warning test message\", \"time\" : \"<!--D-->\", \"ips\" : [\"<!--IP1-->\", \"<!--IP3-->\"], \"ip2\" : \"<!--IP2-->\"}"
  )
fi


if [ $3 = 'multiline' ]; then
  logs=(
               "<!--D--> Exception in thread "main" java.lang.RuntimeException: Something has gone wrong, aborting!"
               "<!--D--> Exception in thread "secondary" java.lang.RuntimeException: Something has gone wrong, aborting!"
               "<!--D--> Exception in thread "test" java.lang.RuntimeException: Something has gone wrong, aborting!"
  )
fi


while [ true ]
do
   WAIT=$(shuf -i $1-$2 -n 1)
   sleep $(echo "scale=4; $WAIT/1000" | bc)
   I=${logs[$RANDOM % ${#logs[@]} ]}
   $3 "$I"
done


