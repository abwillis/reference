awk '/[[:alnum:]]{2,3}\/I\/[[:alnum:]]{6}/' ./tmp1
awk 'match($0, /[[:alnum:]]{2,3}\/I\/[[:alnum:]]{6}/) {print substr($0, RSTART, RLENGTH)}' ./tmp1
