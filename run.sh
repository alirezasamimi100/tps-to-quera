#!/bin/bash

if [ -f Quera_Test.zip ]; then
    rm -f Quera_Test.zip
fi

if [ -d Quera_Test ]; then
    rm -rf Quera_Test
fi

tps gen
mkdir Quera_Test
mkdir Quera_Test/in
mkdir Quera_Test/out

if [[ -f checker/checker.cpp ]]; then
    echo "Checker Found!"
    cp checker/checker.cpp Quera_Test/tester.cpp
else
    echo "No Checker"
fi

cnt=0

TEST=tests/*.in
cnt=0
cp tests/mapping Quera_Test/mapping
cp subtasks.json Quera_Test/subtasks.json
for i in `ls $TEST`
do
    cnt=$(($cnt+1))
    o=`echo $i | sed s/'\.in'/.out/`
    l=`echo $i | cut -d/ -f2 | cut -d. -f1`
    echo "Copying test $cnt"
    cp $i Quera_Test/in/input$cnt.txt
    cp $o Quera_Test/out/output$cnt.txt
    cat Quera_Test/mapping | sed s/$l/$cnt/ > Quera_Test/mapping.new
    mv Quera_Test/mapping.new Quera_Test/mapping
done

g++ -O2 -std=c++17 -o Quera_Test/jc jc.cpp

cd Quera_Test

./jc

rm -f mapping subtasks.json jc

if [[ -f config.json && -f tester.cpp ]]; then
    zip -r Quera_Test.zip in out tester.cpp config.json
elif [[ -f config.json ]]; then
    zip -r Quera_Test.zip in out config.json
elif [[ -f tester.cpp ]]; then
    zip -r Quera_Test.zip in out tester.cpp
else
    zip -r Quera_Test.zip in out
fi

mv Quera_Test.zip ../Quera_Test.zip

cd ..


echo "Finished!"
