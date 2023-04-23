#!/bin/bash

if [[ -f Quera_Test.zip ]]
then
    rm -f Quera_Test.zip
fi

if [[ -d Quera_Test ]]
then
    rm -rf Quera_Test
fi

tps gen
mkdir Quera_Test
mkdir Quera_Test/in
mkdir Quera_Test/out

if [[ -f checker/checker.cpp ]]
then
    echo "Found checker"
    cp checker/checker.cpp Quera_Test/tester.cpp
else
    echo "No checker"
fi

cnt=0

TEST=tests/*.in
cnt=0
if [[ -f tests/mapping && -f subtasks.json ]]
then
    echo "Found subtasks"
    cp tests/mapping Quera_Test/mapping
    cp subtasks.json Quera_Test/subtasks.json
else
    echo "No subtasks"
fi

for i in `ls $TEST`
do
    cnt=$(($cnt+1))
    o=`echo $i | sed s/'\.in'/.out/`
    l=`echo $i | cut -d/ -f2 | cut -d. -f1`
    echo "Copying test $cnt"
    cp $i Quera_Test/in/input$cnt.txt
    cp $o Quera_Test/out/output$cnt.txt
    if [[ -f Quera_Test/mapping ]]
    then
        cat Quera_Test/mapping | sed s/$l/$cnt/ > Quera_Test/mapping.new
        mv Quera_Test/mapping.new Quera_Test/mapping
    fi
done

cd Quera_Test

if [[ -f mapping ]]
then
    echo 'Building config.json'
    python3 ../build_config.py
fi

rm -f mapping subtasks.json BuildConfig

zip -r Quera_Test.zip *

mv Quera_Test.zip ../Quera_Test.zip

cd ..


echo "Finished!"
