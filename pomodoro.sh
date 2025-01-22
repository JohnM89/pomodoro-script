#! /bin/bash

#store arguments with $num

if [[ -z $1 ]]; then
  echo "No focus topic passed"
else
  echo "25min to focus on ($1)!"
fi

#for loop to handle countdown
#echo with -ne and \r for carraiage returns allows updating the same line
for ((i = 1500; i > 0; i--)); do
  echo -ne "Time left: $(date -u --date="@${i}" +%M:%S)\r"
  sleep 1
done

#play an alert
echo -e "\a"

echo "Times up!"
