#!/bin/bash
array=( "ergosterol" "damnableness" "springhouse" "petrify" "preintellectual" "redecay" "tendril" "nonrestrained" "isostemony" "preaccount" "clubman" "pantelleria" "tomato" "talooka" "provenal" "portobello" "clarksburg" "preexecution" "pourer" "chlorpheniramine")

n=-1
c=0
if [ -n "$3" ]
then
   n=$3
fi



while [ $n -ne $c ]
do
   WAIT=$(shuf -i $1-$2 -n 1)
   sleep $(echo "scale=4; $WAIT/1000" | bc)
   I=$(shuf -i 1-4 -n 1)
   D=`date -Iseconds`

   tags="[${array[$RANDOM % ${#array[@]} ]}=${array[$RANDOM % ${#array[@]} ]}] [${array[$RANDOM % ${#array[@]} ]}=${array[$RANDOM % ${#array[@]} ]}] [${array[$RANDOM % ${#array[@]} ]}]"
   IP1="172.172.172.$(($RANDOM % 64))"
   IP2="172.172.172.$(($RANDOM % 64))"
   EXTRA="$tags $IP1 $IP2"

   case "$I" in
      "1") echo "$D ERROR An error is usually an exception that has been caught and not handled. $EXTRA"
      ;;
      "2") echo "$D INFO This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. This is less important than debug log and is often used to provide context in the current task. $EXTRA"
      ;;
      "3") echo "$D WARN A warning that should be ignored is usually at this level and should be actionable. $EXTRA"
      ;;
      "4") echo "$D DEBUG This is a debug log that shows a log that can be ignored. $EXTRA"
      ;;
   esac
   c=$(( c+1 ))
done
