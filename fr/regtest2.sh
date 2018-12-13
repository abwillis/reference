#!/bin/bash
#Script to take regex and text as parameters

while :
do
#  echo 'Enter your regular expression'
#  read REGXS
#  echo $REGXS >./tmp2
#  REGEXS=$(sed -e 's/\//\\\//g' ./tmp2)
 # REGEXS=echo '/'$REGEXS'/'
  echo 'Enter your text'
  read TEXT
  echo $TEXT >./tmp1
  echo
  echo 'The match: '

  #echo awk "'/"$REGEXS"/'" ./tmp1 >check.sh
  #awk '/\([[:alpha:]]-[[:alnum:]]{4}[[:punct:]] [[:alnum:]]{2,3}\)/' ./tmp1 This will show the entire Line
awk 'match($0, /ibm|att|at\&t|dca|sn\=|sn:|sn\-|iam|identity/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/ibm|att|at\&t|dca|sn\=|sn:|sn\-|iam|identity/'; echo
awk 'match($0, /\([[:alpha:]]-[[:alnum:]]{4}[[:punct:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alpha:]]-[[:alnum:]]{4}[[:punct:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alnum:]]{6}[[:punct:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alnum:]]{6}[[:punct:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\(\+[[:alnum:]]{5}[[:punct:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\(\+[[:alnum:]]{5}[[:punct:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\(\+\+[[:alnum:]]{4}[[:punct:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\(\+\+[[:alnum:]]{4}[[:punct:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alnum:]]{4}\+[[:alnum:]][[:punct:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alnum:]]{4}\+[[:alnum:]][[:punct:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alnum:]]{5}\+[[:punct:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alnum:]]{5}\+[[:punct:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alpha:]]-[[:alnum:]]{4} [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alpha:]]-[[:alnum:]]{4} [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alnum:]]{6} [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alnum:]]{6} [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\(\+[[:alnum:]]{5} [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\(\+[[:alnum:]]{5} [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\(\+\+[[:alnum:]]{4} [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\(\+\+[[:alnum:]]{4} [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alnum:]]{4}\+[[:alnum:]] [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alnum:]]{4}\+[[:alnum:]] [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /\([[:alnum:]]{5}\+ [[:alnum:]]{2,3}\)/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\([[:alnum:]]{5}\+ [[:alnum:]]{2,3}\)/'; echo
awk 'match($0, /[[:punct:]][[:alpha:]]\-[[:alnum:]]{4}[[:punct:]][[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:punct:]][[:alpha:]]\-[[:alnum:]]{4}[[:punct:]][[:alnum:]]{2,3}/'; echo
awk 'match($0, /[[:punct:]][[:alnum:]]{6}[[:punct:]][[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:punct:]][[:alnum:]]{6}[[:punct:]][[:alnum:]]{2,3}/'; echo
awk 'match($0, /[[:punct:]]\+[[:alnum:]]{5}[[:punct:]][[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:punct:]]\+[[:alnum:]]{5}[[:punct:]][[:alnum:]]{2,3}/'; echo
awk 'match($0, /[[:punct:]]\+\+[[:alnum:]]{4}[[:punct:]][[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:punct:]]\+\+[[:alnum:]]{4}[[:punct:]][[:alnum:]]{2,3}/'; echo
awk 'match($0, /[[:punct:]][[:alnum:]]{5}\+[[:punct:]][[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:punct:]][[:alnum:]]{5}\+[[:punct:]][[:alnum:]]{2,3}/'; echo
awk 'match($0, /[[:punct:]][[:alnum:]]{4}\+[[:alnum:]][[:punct:]][[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:punct:]][[:alnum:]]{4}\+[[:alnum:]][[:punct:]][[:alnum:]]{2,3}/'; echo
awk 'match($0, /^[[:alpha:]]-[[:alnum:]]{4} [[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/^[[:alpha:]]-[[:alnum:]]{4} [[:alnum:]]{2,3}/'; echo
awk 'match($0, /^[[:alnum:]]{6} [[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/^[[:alnum:]]{6} [[:alnum:]]{2,3}/'; echo
awk 'match($0, /^\+[[:alnum:]]{5} [[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/^\+[[:alnum:]]{5} [[:alnum:]]{2,3}/'; echo
awk 'match($0, /^\+\+[[:alnum:]]{4} [[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/^\+\+[[:alnum:]]{4} [[:alnum:]]{2,3}/'; echo
awk 'match($0, /^[[:alnum:]]{4}\+[[:alnum:]] [[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/^[[:alnum:]]{4}\+[[:alnum:]] [[:alnum:]]{2,3}/'; echo
awk 'match($0, /^[[:alnum:]]{5}\+ [[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/^[[:alnum:]]{5}\+ [[:alnum:]]{2,3}/'; echo
awk 'match($0, /\/[[:alpha:]]-[[:alnum:]]{4}[[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\/[[:alpha:]]-[[:alnum:]]{4}[[:alnum:]]{2,3}/'; echo
awk 'match($0, /\/[[:alnum:]]{6}[[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\/[[:alnum:]]{6}[[:alnum:]]{2,3}/'; echo
awk 'match($0, /\/\+[[:alnum:]]{5}[[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\/\+[[:alnum:]]{5}[[:alnum:]]{2,3}/'; echo
awk 'match($0, /\/\+\+[[:alnum:]]{4}[[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\/\+\+[[:alnum:]]{4}[[:alnum:]]{2,3}/'; echo
awk 'match($0, /\/[[:alnum:]]{4}\+[[:alnum:]]{3,4}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\/[[:alnum:]]{4}\+[[:alnum:]]{3,4}/'; echo
awk 'match($0, /\/[[:alnum:]]{5}\+[[:alnum:]]{2,3}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/\/[[:alnum:]]{5}\+[[:alnum:]]{2,3}/'; echo
awk 'match($0, /[[:alnum:]]{2,3}\/\/[[:alpha:]]-[[:alnum:]]{4}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:alnum:]]{2,3}\/\/[[:alpha:]]-[[:alnum:]]{4}/'; echo
awk 'match($0, /[[:alnum:]]{2,3}\/\/[[:alnum:]]{6}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:alnum:]]{2,3}\/\/[[:alnum:]]{6}/'; echo
awk 'match($0, /[[:alnum:]]{2,3}\/\/\+[[:alnum:]]{5}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:alnum:]]{2,3}\/\/\+[[:alnum:]]{5}/'; echo
awk 'match($0, /[[:alnum:]]{2,3}\/\/\+\+[[:alnum:]]{4}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:alnum:]]{2,3}\/\/\+\+[[:alnum:]]{4}/'; echo
awk 'match($0, /[[:alnum:]]{2,3}\/\/[[:alnum:]]{4}\+[[:alnum:]]/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:alnum:]]{2,3}\/\/[[:alnum:]]{4}\+[[:alnum:]]/'; echo
awk 'match($0, /[[:alnum:]]{2,3}\/\/[[:alnum:]]{5}\+/) {print substr($0, RSTART, RLENGTH)}' ./tmp1; echo '/[[:alnum:]]{2,3}\/\/[[:alnum:]]{5}\+/'; echo

# awk "'match(\$0, /"$REGEXS"/) {print substr(\$0, RSTART, RLENGTH)}'" ./tmp1
# sh check.sh
  echo
done


