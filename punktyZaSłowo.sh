#!/bin/bash
declare -A alphabet=( ["a"]=1 ["b"]=3 ["c"]=3 ["d"]=2 ["e"]=1 ["f"]=4 ["g"]=2 ["h"]=4 ["i"]=1 ["j"]=8 ["k"]=5 ["l"]=1 ["m"]=3 ["n"]=1 ["o"]=1 ["q"]=10 ["p"]=3 ["r"]=1 ["s"]=1 ["t"]=1 ["u"]=1 ["v"]=4 ["w"]=4 ["x"]=8 ["y"]=4 ["z"]=10 )

function wordCount(){
    i=$1
    i="$(echo $i | tr '[A-Z]' '[a-z]')"
    sum=0
    k=0
    while ((k++ < ${#i} ))
    do
        char=$(expr substr "$i" $k 1)
        sum=$(($sum + alphabet[$char]))
    done    
    if grep -q $i "$File";
    then
        echo $i POPRAWNE  $sum  
    else
        if [ $bp -eq 1 ];
        then
            echo $i NIEPOPRAWNE
        elif [ $bw -eq 0 ];
        then
            echo $i NIEPOPRAWNE $sum
        fi   
    fi
}

case $1 in
        -bp)
                shift
                bp=1
                bw=0
                ;;
        -bw)
                shift
                bp=0
                bw=1
                ;;

        -h)
               echo -e "Użycie: punktyZaSłowo.sh [OPTIONS] [DICTIONARY] [WORDS]
Zlicza punkty za litery w słowie i sprawdza w słowniku jego poprawność, jak podczas gry w Scrabble.
OPTIONS:
               -bp - nie liczy punktów za niepoprawne słowa
               -bw - nie wyświetla niepoprawnych słów
               -h - wyświetla pomoc 
DICTIONARY - użytkownik może ustawić ścieżkę do odpowiedniego słownika
WORDS - słowa mogą być podane jako parametry, jeśli nie, będzie można je wprowadzić poprzez standardowe wejście.
               "

                ;;
        *)
            bp=0
            bw=0
            ;;
esac

if test -f "$1";
then
    File=$1
    shift
else
    File=/usr/share/dict/words
fi
counter=1
if [ "$#" -ne "0" ];
then
    for i
    do
        wordCount $i
        counter=$((counter+1))
    done
fi

if [ $counter -eq 1 ];
then
    while read i
    do
        wordCount $i
    done
fi