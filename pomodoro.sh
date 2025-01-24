#! /bin/bash

#store arguments with $num

if [[ -z $1 ]]; then
  echo "No focus topic passed"
else
  echo "25min to focus on ($1)!"
fi

#simple tracking of tasks
echo $1 >>.pomodorotasks
#clear terminal
clear
#set variables for animation
val="_"
val2="-"
len1=0
len2=16
#amount=1
max_length=16
study=1500
switch=0
#break=300
#hide the cursor
echo -ne "\e[?25l"

#for loop to handle countdown
#echo with \033[<row>;<col>H for carraiage returns allows updating the same line
for ((i = 0; i < study; i++)); do
  time=$((1500 - i))

  if ((len1 == max_length)); then

    ((switch = 1))
  elif ((len1 == 0)); then
    ((switch = 0))
  fi

  if ((switch == 0)); then
    len1=$((len1 += 1))
    len2=$((len2 -= 1))
  elif ((switch == 1)); then
    len1=$((len1 -= 1))
    len2=$((len2 += 1))
  fi

  #generate x spaces with printf and replace with tr
  line1=$(printf "%${len1}s" | tr " " "$val")
  line2=$(printf "%${len2}s" | tr " " "$val2")

  echo -ne "\033[1;0HTime left: $(date -u --date="@${time}" +%M:%S)"
  #echo -ne "\033[2;0H\033[K"
  echo -ne "\033[2;0H$line1$line2"
  #echo -ne "$len1\t"
  sleep 1
done

#play an alert
echo -e "\a"

echo "Times up!"
#show cursor again
echo -ne "\e[?25h\n"
