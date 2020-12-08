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

YEAR=$(date +'%Y')
AGE=$(jot -r 1 18 99);
YYYY=$(expr $YEAR - $AGE);
M=$(jot -r 1 1 12);
MM=$(printf %02d $M);
D=$(jot -r 1 1 28);
DD=$(printf %02d $D);
XXX=$(jot -r 1 100 999);
YYYYMMDDXXX=$(printf $YYYY$MM$DD$XXX);
YYMMDDXXX=$(printf ${YYYY: -2}$MM$DD$XXX);

X=$(josefs_luhn_checksum $YYMMDDXXX);
echo $YYYY$MM$DD$XXX$X | pbcopy; echo $YYYY$MM$DD$XXX$X;