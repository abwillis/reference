#!/bin/bash
#Script to take regex and text as parameters

while :
do
  echo 'Enter your regular expression'
  read REGXS
  echo $REGXS >./tmp2
  REGEXS=$(sed -e 's/\//\\\//g' ./tmp2)
  REGEXS=echo '/'$REGEXS'/'
  echo 'Enter your text'
  read TEXT
  echo $TEXT >./tmp1
  echo
  echo 'The match: '

  echo awk "'/"$REGEXS"/'" ./tmp1 >check.sh
  echo awk "'match(\$0, /"$REGEXS"/) {print substr(\$0, RSTART, RLENGTH)}'" ./tmp1 >>check.sh
# awk "'match(\$0, /"$REGEXS"/) {print substr(\$0, RSTART, RLENGTH)}'" ./tmp1
  sh check.sh
  echo
done


