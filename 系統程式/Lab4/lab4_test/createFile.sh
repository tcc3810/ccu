#!/bin/bash -x
ext=(doc xls ppt txt mp3 pdf html jpg png gif exe gp3 mov mp4)
dirfile="/tmp/$USER/esllab20140411.sp"


childdirname_1="Test1"
childdirname_2="Test2"
childdirname_3="Test3"
childdirname_4="Test4"
childdirname_5="Test5"
filename="REG_"
filename1="aaa"
filename2="bbb"
filename3="ccc"
fifoname1="Fifo1"
fifoname2="Fifo2"
fifoname3="Fifo3"
fifoname4="Fifo4"
fifoname5="Fifo5"
linkname1="testLink1"
linkname2="testLink2"
linkname3="testLink3"
if [ -f $dirfile ] ;
then
	dirname=$(cat $dirfile)
else
	mkdir -p /tmp/$USER
	dirname=/tmp/$USER/$(basename $(tempfile))
	echo $dirname > $dirfile
fi
rm -rf $dirname

mkdir -p "$dirname"/"$childdirname_1"
mkdir -p "$dirname"/"$childdirname_2"
mkdir -p "$dirname"/"$childdirname_3"
mkdir -p "$dirname"/"$childdirname_4"
mkdir -p "$dirname"/"$childdirname_5"
touch "$dirname"/"$childdirname_1"/"$filename1"
touch "$dirname"/"$childdirname_1"/"$filename2"
touch "$dirname"/"$childdirname_2"/"$filename3"
chmod 255 "$dirname"/"$childdirname_1"
chmod 255 "$dirname"/"$childdirname_2"


for (( i=0; i < 50; i=i+1 ))
do
		file=${filename}$RANDOM
		touch "$dirname"/"$file".${ext[$RANDOM*14/32767]}
done

mkfifo "$dirname"/"$fifoname1"
mkfifo "$dirname"/"$fifoname2"
mkfifo "$dirname"/"$fifoname3"
mkfifo "$dirname"/"$fifoname4"
mkfifo "$dirname"/"$fifoname5"

ln -s "$dirname"/"$childdirname_3" "$dirname"/"$linkname1"
ln -s "$dirname"/"$childdirname_4" "$dirname"/"$linkname2"
ln -s "$dirname"/"$childdirname_5" "$dirname"/"$linkname3"
rm -r "$dirname"/"$childdirname_4"
