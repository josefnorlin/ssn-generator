#!/bin/sh

# Returns Luhn checksum for supplied sequence
josefs_luhn_checksum() {
        checksum=0;
        multiples=212121212;
        for (( i = 0; i < ${#1}; ++i )); do
        base=${1:$i:1};
        multiple=${multiples:$i:1};
        multiplied=$(( $base * $multiple ));
        if [[ ${#multiplied} > 1 ]]
        then
        checksum=$(( $checksum+${multiplied:0:1}+${multiplied:1:1} ))
        else
        checksum=$(( $checksum+$multiplied ))
        fi
        done

        luhn1="$(($checksum % 10))" # mod 10 the sum to get single digit checksum
        luhn2=$(( 10 - $luhn1 ))
        luhn3=$(( $luhn2 % 10 ))
        echo "$luhn3"
}

randomize() {
  echo $(jot -r 1 0 9)
}

CLEARING=8$(randomize)$(randomize)$(randomize);
ACCOUNT_NUMBER=$(randomize)$(randomize)$(randomize)$(randomize)$(randomize)$(randomize)$(randomize)$(randomize)$(randomize);
#ACCOUNT_NUMBER=853040161;
ACCOUNT_NUMBER_CONTROL=$(josefs_luhn_checksum $ACCOUNT_NUMBER);
echo $CLEARING$ACCOUNT_NUMBER$ACCOUNT_NUMBER_CONTROL;