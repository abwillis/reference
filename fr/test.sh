#!/bin/bash
  echo 'Enter your regular expression'
  read REGEXS
  echo \'~ $REGEXS\' >./tmp2
  REGXS="$(cat ./tmp2)"
  echo $REGXS
